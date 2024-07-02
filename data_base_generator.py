import json
from PIL import Image

def parase_image_width_and_height(filename: str) -> tuple[int, int]:
    try:
        with Image.open(filename) as img:
            width, height = img.size
            return (width, height)
    except IOError:
        print(f"Unable to open image file: {filename}")
        return (1, 1)
  
def write_today_json(data, filename='today.json'):
    """
    将数据写入指定的 today.json 文件。

    :param data: 要写入的 JSON 数据
    :param filename: JSON 文件名，默认为 'today.json'
    """
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)
    print(f"JSON 数据已写入文件: {filename}")

def insert_into_history_json(new_data, filename='history.json'):
    """
    将新数据插入到指定的 history.json 文件的头部。

    :param new_data: 要插入的 JSON 数据
    :param filename: JSON 文件名，默认为 'history.json'
    """
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            history_data = json.load(f)
    except (json.JSONDecodeError, FileNotFoundError):
        history_data = []

    history_data.insert(0, new_data)

    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(history_data, f, ensure_ascii=False, indent=4)
    print(f"新数据已成功插入到 {filename} 文件的头部。")

def print_json_data(data):
    # 将字典转换为 JSON 格式
    json_data = json.dumps(data, ensure_ascii=False, indent=4)

    # 打印生成的 JSON 数据
    print(json_data)

if __name__ == "__main__":
    id = 6 # 需要改
    tag = "苹果格调" # 可能需要改
    title = "你读的书越多，你就会发现，身边的人都是优秀不带优越感的人。他们明亮但不刺眼、自信又懂得收敛，让你向往的同时，又给你源源不断的正能量。" # 需要改
    cardStyle = "vertical" #vertical, zstack
    date = "2024年7月3日" # 需要改
    today_image_name = "6.jpg" # 需要改
    image: str = "https://gitee.com/huangrunhua/Quote/raw/main/images/" + today_image_name
    source: str = "《》" # 需要改
    jumpScheme: str = "" # 需要改
    
    local_image_name = "images/" + today_image_name
    (coverImageWidth, coverImageHeight) = parase_image_width_and_height(local_image_name)
    
    data = {
        "id": id,
        "tag": tag,
        "title": title,
        "cardStyle": cardStyle,
        "date": date,
        "image": image,
        # "source": source, # 可能不存在
        "coverImageWidth": coverImageWidth,
        "coverImageHeight": coverImageHeight,
        # "jumpScheme": jumpScheme # 可能不存在
    }
    
    print_json_data(data)
    write_today_json(data)
    insert_into_history_json(data)
    
    