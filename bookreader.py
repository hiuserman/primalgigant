from PIL import Image
from pyzbar.pyzbar import decode, ZBarSymbol
import requests

img = Image.open("image/2.jpg")

results = decode(img)

for result in results:
    print("data:", result.data.decode('utf-8'))
    print("type:", result.type)

    isbn = result.data.decode('utf-8')
    url = f"https://www.googleapis.com/books/v1/volumes?q=isbn:{isbn}"

    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        if 'items' in data:
            book_info = data['items'][0]['volumeInfo']
            print("Title:", book_info.get('title', 'N/A'))
            print("Authors:", ', '.join(book_info.get('authors', ['N/A'])))
            print("Publisher:", book_info.get('publisher', 'N/A'))
            print("Published Date:", book_info.get('publishedDate', 'N/A'))
            print("image:", book_info.get('imageLinks', {}).get('thumbnail', 'N/A'))
        else:
            print("No book found for this ISBN.")
    else:
        print("Error fetching book information.")
