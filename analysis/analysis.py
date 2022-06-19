import re
import json
import dataclasses


@dataclasses.dataclass(init=True, repr=True, eq=True, order=False, unsafe_hash=False, frozen=True)
class Row:
    month: str
    day: str
    hour: str
    min: str
    sec: str
    OUT: str
    SRC: str
    LEN: str


def save_row(target_storage: dict, row: Row, composite_key: str):
    if not target_storage.get(composite_key):
        target_storage[composite_key] = {
            'users': {},
            'requests_count': 0,
            'data_len': 0,
        }
    this = target_storage[composite_key]
    this['requests_count'] += 1
    this['data_len'] += int(row.LEN)
    if not row.SRC in this['users'].keys():
        this['users'][row.SRC] = list()
    this['users'][row.SRC].append(
        dataclasses.asdict(row))


def analyze_file(file_name):
    storage_by_month = {}
    storage_by_day = {}
    storage_by_hour = {}
    storage_by_min = {}

    with open(file_name) as file:
        regex_pattern = r'^(?P<month>\S{1,30})\s(?P<day>\S{1,5})\s(?P<hour>\S{2}):(?P<min>\S{2}):(?P<sec>\S{2})\s(.*?)OUT=(?P<OUT>\S{0,30})\s(.*?)SRC=(?P<SRC>\S{0,30})\s(.*?)LEN=(?P<LEN>\S{0,30})\s(.*?)$'
        sequence = re.compile(regex_pattern)
        index = 0
        for line in file:
            index += 1
            match = re.match(sequence, line)
            if not match:
                continue

            row = Row(**match.groupdict())
            save_row(storage_by_month, row, row.month)
            save_row(storage_by_day, row, f'{row.month}:{row.day}')
            save_row(storage_by_hour, row, f'{row.month}:{row.day}:{row.hour}')
            save_row(storage_by_min, row,
                     f'{row.month}:{row.day}:{row.hour}:{row.min}')

        file.close()
        for storage in [storage_by_month, storage_by_day, storage_by_hour, storage_by_min]:
            for composite_key in storage.keys():
                top = {}
                for user in storage[composite_key]['users'].keys():
                    requests_count = len(storage[composite_key]['users'][user])
                    if not top.get(requests_count):
                        top[requests_count] = []
                    top[requests_count].append(user)
                storage[composite_key]['users_by_requests_count'] = top
    output_content = ""
    for day_key in list(storage_by_day.keys()):
        day = storage_by_day[day_key]
        output_content += day_key + "\n\n"
        for key in sorted(map(int, list(day['users_by_requests_count'].keys())), reverse=True):
            output_content += "Requests count: " + str(key) + "\n" + ", ".join(day['users_by_requests_count'][key]) + "\n\n"
        return output_content
