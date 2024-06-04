import requests
from bs4 import BeautifulSoup
import re
from urllib.parse import urljoin, urlparse

# Kullanıcıdan başlangıç URL'sini al
start_url = input("Başlangıç URL'sini girin: ")

# Ziyaret edilen URL'leri takip etmek için bir set kullanıyoruz
visited_urls = set()
# Bulunan yazılım ve sürüm bilgilerini saklamak için bir liste kullanıyoruz
software_versions = []

def extract_links_and_versions(url):
    global visited_urls
    # Eğer URL daha önce ziyaret edilmişse atla
    if url in visited_urls:
        return
    visited_urls.add(url)
    
    try:
        response = requests.get(url)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        
        print(f"Ziyaret ediliyor: {url}")  # Ziyaret edilen URL'i yazdır
        
        # HTML'deki tüm bağlantıları bul
        links = soup.find_all('a', href=True)
        
        for link in links:
            href = link['href']
            # Tam URL oluştur ve aynı domain olup olmadığını kontrol et
            full_url = urljoin(url, href)
            if urlparse(full_url).netloc == urlparse(start_url).netloc:
                extract_links_and_versions(full_url)
        
        # HTML'deki sürüm bilgilerini regex ile ara
        version_patterns = [
            re.compile(r'\bversion\s?(\d+\.\d+\.\d+)\b', re.I),
            re.compile(r'\bv(\d+\.\d+\.\d+)\b', re.I),
            re.compile(r'\b(\d+\.\d+\.\d+)\b', re.I)
        ]
        
        for pattern in version_patterns:
            matches = pattern.findall(soup.text)
            for match in matches:
                print(f"{url} adresinde sürüm bulundu: {match}")  # Bulunan sürüm bilgilerini yazdır
                software_versions.append((url, match))
    
    except requests.RequestException as e:
        print(f"{url} adresine erişim başarısız: {e}")

# Tarayıcıyı başlat
extract_links_and_versions(start_url)

# Sonuçları yazdır
print("\nBulunan sürümler:")
for url, version in software_versions:
    print(f"URL: {url} - Sürüm: {version}")
