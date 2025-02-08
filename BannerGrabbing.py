import os
import subprocess

def print_menu(title, options):
    while True:
        print(f"\n{title}")
        print("=" * len(title))
        for i, option in enumerate(options, 1):
            print(f"{i}. {option}")
        try:
            choice = int(input("Seçiminizi yapın: "))
            if 1 <= choice <= len(options):
                return choice
            else:
                print("Geçersiz seçim, lütfen tekrar deneyin.")
        except ValueError:
            print("Hatalı giriş, lütfen bir sayı girin.")

def main():
    print("\nNmap Banner Grabbing Script\n===========================")
    
    # Kullanıcıdan hedef IP veya domain alma
    while True:
        try:
            hedef = input("Hedef IP veya Domain: ")
            if hedef.strip():
                break
            else:
                print("Hedef boş olamaz, lütfen geçerli bir giriş yapın.")
        except OSError:
            print("Girdi desteklenmiyor, varsayılan hedef: 127.0.0.1")
            hedef = "127.0.0.1"
            break
    
    # Tarama yöntemi seçimi
    tarama_secenekleri = [
        "Normal Taramayla (-sV)",
        "Ping Atlamalı (-sV -Pn)",
        "UDP Taraması (-sU)",
        "Agresif Tarama (-sV --version-intensity 5)",
        "NSE Script ile Banner Çekme (--script=banner)"
    ]
    tarama_secimi = print_menu("Tarama Yöntemini Seçin:", tarama_secenekleri)
    
    # Port kapsamı seçimi
    port_secenekleri = [
        "Sık Kullanılan Portlar",  # Standart servis portları
        "Tüm Portlar (1-65535)"
    ]
    port_secimi = print_menu("Port Kapsamını Seçin:", port_secenekleri)
    
    # Nmap komutu oluştur
    tarama_parametreleri = ["-sV", "-sV -Pn", "-sU", "-sV --version-intensity 5", "--script=banner"]
    secilen_tarama = tarama_parametreleri[tarama_secimi - 1]
    
    if port_secimi == 1:
        portlar = "-p 21,22,23,25,53,80,110,139,143,443,445,465,587,993,995,1433,1521,3306,3389,5432,6379,8080,8443"
    else:
        portlar = "-p-"  # Tüm portları tara
    
    # Final Nmap komutu
    nmap_komutu = f"sudo nmap {secilen_tarama} {portlar} {hedef}"
    print(f"\nÇalıştırılan Komut: {nmap_komutu}\n")
    
    # Komutu çalıştır ve sonucu göster
    try:
        sonuc = subprocess.run(nmap_komutu, shell=True, text=True)
    except Exception as e:
        print(f"Hata oluştu: {e}")
    
if __name__ == "__main__":
    main()
