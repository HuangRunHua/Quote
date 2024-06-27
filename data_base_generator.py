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
    title = "因为从心底害怕自己不值得被爱，我们孑然一身，”那一段是这样的，“然而就是因为孑然一身，才让我们认为自己不值得被爱。有一天，你不知道是什么时候，你会驱车上路。有一天，你不知道是什么时候，他或是她会蓦然出现。你会被爱，因为你今生第一次真正不再孤独。你会选择不再孤独下去。"
    cardStyle = "vertical" #vertical, zstack
    date = "2024年6月27日"
    today_image_name = "0.jpg"
    image: str = "https://gitee.com/huangrunhua/Quote/raw/main/images/" + today_image_name
    source: str = "《岛上书店》"
    jumpScheme: str = "https://weread.qq.com/book-detail?type=1&senderVid=308308448&v=c7032220813ab6d0fg015d45"
    
    local_image_name = "images/" + today_image_name
    (coverImageWidth, coverImageHeight) = parase_image_width_and_height(local_image_name)
    
    data = {
        "id": id,
        "tag": tag,
        "title": title,
        "cardStyle": cardStyle,
        "date": date,
        "image": image,
        "source": source, # 可能不存在
        "coverImageWidth": coverImageWidth,
        "coverImageHeight": coverImageHeight,
        "jumpScheme": jumpScheme # 可能不存在
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
    
    