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
    

if __name__ == "__main__":
    id = 0
    tag = "信鸽辉光"
    title = "跨过星河迈过月亮去迎接更好的自己。"
    cardStyle = "zstack" #vertical
    date = "2024年6月27日"
    today_image_name = "0.jpg"
    image: str = "https://gitee.com/huangrunhua/Quote/raw/main/images/" + today_image_name
    source: str = "《小小巴黎书店》"
    
    local_image_name = "images/" + today_image_name
    (coverImageWidth, coverImageHeight) = parase_image_width_and_height(local_image_name)
    
    data = {
        "id": id,
        "tag": tag,
        "title": title,
        "cardStyle": cardStyle,
        "date": date,
        "image": image,
        "source": source,
        "coverImageWidth": coverImageWidth,
        "coverImageHeight": coverImageHeight
    }
    
    # 写入today.json文件
    today_json_file = 'today.json'

    with open(today_json_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

    print(f"JSON 数据已写入文件: {today_json_file}")
    
    # 写入history.json文件
    history_json_file = 'history.json'
    
    # 读取现有 JSON 数据
    with open(history_json_file, 'r', encoding='utf-8') as f:
        try:
            history_data = json.load(f)
        except json.JSONDecodeError:
            history_data = []

    # 将新数据添加到数组中
    history_data.append(data)

    # 写入更新后的 JSON 数据
    with open(history_json_file, 'w', encoding='utf-8') as f:
        json.dump(history_data, f, ensure_ascii=False, indent=4)

    print(f"新数据已成功插入到 {history_json_file} 文件中。")
    
    