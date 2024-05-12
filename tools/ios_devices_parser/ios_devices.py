import json
import re
import sqlite3
import sys

import jsonschema
import requests
from bs4 import BeautifulSoup

generation_regex = r'(\d+(st|nd|rd|th)\s+gen)'

device_traits_db = '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/usr/standalone/device_traits.db'

sql_query = """
SELECT DISTINCT
    CASE
        WHEN INSTR(ProductType, '-') > 0 THEN SUBSTR(ProductType, 1, INSTR(ProductType, '-') - 1)
        ELSE ProductType
    END,
    ProductDescription
FROM DEVICES;
"""

ios_devices_url = 'https://www.ios-resolution.com'

result_schema = {
    "$schema": "http://json-schema.org/draft-07/schema#",
    "type": "array",
    "items": {
        "type": "object",
        "properties": {
            "device": {
                "type": "string"
            },
            "logicalWidth": {
                "type": "number"
            },
            "logicalHeight": {
                "type": "number"
            },
            "width": {
                "type": "number"
            },
            "height": {
                "type": "number"
            },
            "ppi": {
                "type": "number"
            },
            "scaleFactor": {
                "type": "number"
            },
            "screenDiagonal": {
                "type": "number"
            },
            "releaseDate": {
                "type": "string",
                "format": "date"
            },
            "hardware_names": {
                "type": "array",
                "items": {
                    "type": "string"
                }
            }
        },
        "required": [
            "device",
            "logicalWidth",
            "logicalHeight",
            "width",
            "height",
            "ppi",
            "scaleFactor",
            "screenDiagonal",
            "releaseDate",
            "hardware_names"
        ]
    }
}


def to_camel_case(text):
    # Split the text into words based on spaces
    words = text.split()
    # Make the first word lowercase and the rest of the words title case
    return ''.join([words[0].lower()] + [word.capitalize() for word in words[1:]])


def parse_device(text):
    return re.sub(generation_regex, lambda x: f"({x.group(0).replace('gen', 'generation')})", text)


def parse_value(value):
    try:
        return float(value.replace('"', ''))
    except ValueError:
        return value


def invert_dict(input_dict):
    inverted_dict = {}
    for k, v in input_dict.items():
        if v not in inverted_dict:
            inverted_dict[v] = [k]
        else:
            inverted_dict[v].append(k)
    return inverted_dict


def get_devices_mapping():
    conn = sqlite3.connect(device_traits_db)
    cur = conn.cursor()

    cur.execute(sql_query)

    results = cur.fetchall()

    cur.close()
    conn.close()

    results = dict(results)

    return invert_dict(results)


def fetch_ios_devices():
    response = requests.get(ios_devices_url)

    if response.status_code == 200:
        return response.text


def parse_devices_html(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    # Find the table with class 'devices'
    device_table = soup.find('table', class_='devices')
    table_rows = device_table.find_all('tr')  # Find all rows in this table

    data = []
    for row in table_rows:
        cells = row.find_all('td')

        row_data = {}
        for cell in cells:
            spans = cell.find('span')
            if spans and ':' in spans.text:
                key = spans.text.strip(':').strip()
                key = to_camel_case(key)
                value = cell.get_text(strip=True).replace(spans.text, '')
                row_data[key] = parse_value(value)
            else:
                row_data['device'] = cell.get_text(strip=True)

        if row_data:
            row_data['device'] = parse_device(row_data['device'])
            data.append(row_data)

    return data


def map_devices(mapping, devices):
    for device in devices:
        device['hardware_names'] = mapping.get(device['device'], [])

    return devices


def validate_result(result):
    jsonschema.validate(result, result_schema)


def output_result(result):
    with open('../../generated/devices.json', 'w') as file:
        file.write(json.dumps(result, indent=2, ensure_ascii=True))


if __name__ == '__main__':
    html_content = fetch_ios_devices()

    mapping = get_devices_mapping()
    devices = parse_devices_html(html_content)

    result = map_devices(mapping, devices)

    validate_result(result)

    output_result(result)
