import os
import re

TARGET_DIR = '/Users/liberyus/development/dedi/lib'

twake_linagora_regex = re.compile(r'(twake|linagora)', re.IGNORECASE)
fluffy_name_regex = re.compile(r'fluffy', re.IGNORECASE)

files_to_analyze = []

# Collect all files
all_dart_contents = {}
for root, _, files in os.walk(TARGET_DIR):
    for file in files:
        if not file.endswith('.dart'): continue
        filepath = os.path.join(root, file)
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            all_dart_contents[filepath] = content
        
        # We want to analyze if it matches our criteria
        if twake_linagora_regex.search(file) or twake_linagora_regex.search(content) or fluffy_name_regex.search(file):
            files_to_analyze.append(filepath)

report = []

for filepath in files_to_analyze:
    relpath = os.path.relpath(filepath, '/Users/liberyus/development/dedi')
    filename = os.path.basename(filepath)
    content = all_dart_contents[filepath]
    
    # Try to extract class name
    class_match = re.search(r'class\s+([a-zA-Z0-9_]+)', content)
    class_name = class_match.group(1) if class_match else "(Sınıf bulunamadı, muhtemelen enum veya fonksiyon)"
    
    # Determine type based on path
    file_type = "Bilinmeyen"
    purpose = "Projeye ait bir dosya"
    
    if "pages/twake_welcome" in relpath:
        file_type = "UI Sayfası (Eski Twake Giriş Ekranı)"
        purpose = "Twake'in orijinal giriş (login/welcome) ekranı."
    elif "widgets/twake_components" in relpath or "widgets" in relpath:
        file_type = "UI Bileşeni (Widget)"
        purpose = "Arayüzde gösterilen bir buton, yükleme ikonu veya menü."
    elif "domain/usecase" in relpath:
        file_type = "İş Mantığı (Usecase/Interactor)"
        purpose = "Uygulamanın arka planında veri çekme veya bir aksiyon alma mantığı."
    elif "domain/model" in relpath:
        file_type = "Veri Modeli"
        purpose = "Gelen veriyi (JSON vb.) Dart nesnesine dönüştürmek için kullanılan model."
    elif "domain/exception" in relpath:
        file_type = "Hata Sınıfı"
        purpose = "Özel hata durumlarını (try-catch) yönetmek için."
    elif "event" in relpath:
        file_type = "Matrix Event Tipi"
        purpose = "Matrix protokolündeki özel Twake mesaj türlerini (event) tanımlamak."
    elif "app_twake_" in filename or "linagora_app" in filename:
        file_type = "Özel Veri Modeli"
        purpose = "Twake veya Linagora ekosistemine ait özel uygulama içi verileri tutar."
    elif filename == "twake_app.dart":
        file_type = "Ana UI Kök Sınıfı"
        purpose = "Uygulamanın temel Material App ağacını başlatan dosya (Şu an DediApp olarak adlandırılmış)."
        
    # Check if used
    import_path_str = f"package:fluffychat/{relpath[4:]}"
    usage_count = 0
    used_in = []
    
    for other_file, other_content in all_dart_contents.items():
        if other_file == filepath: continue
        # if the import path or filename exists in other file
        if import_path_str in other_content or f"'{filename}'" in other_content or f'"{filename}"' in other_content:
            usage_count += 1
            other_rel = os.path.relpath(other_file, '/Users/liberyus/development/dedi')
            used_in.append(other_rel)
            
    report.append({
        "file": relpath,
        "class": class_name,
        "type": file_type,
        "purpose": purpose,
        "is_used": usage_count > 0,
        "used_in": used_in[:5],
        "usage_count": usage_count
    })

# output as markdown
with open('/Users/liberyus/development/dedi/deep_report.md', 'w') as f:
    f.write("# Tek Tek Dosya Analizi (Twake, Linagora, Fluffy)\n\n")
    
    # Sort by used/unused
    for item in sorted(report, key=lambda x: (not x["is_used"], x["file"])):
        status = "✅ AKTİF OLARAK KULLANILIYOR" if item["is_used"] else "❌ HİÇBİR YERDE KULLANILMIYOR (SİLİNEBİLİR)"
        
        f.write(f"### Dosya: `{item['file']}`\n")
        f.write(f"- **Ne İşe Yarar:** {item['type']} - {item['purpose']}\n")
        f.write(f"- **Sınıf Adı:** `{item['class']}`\n")
        f.write(f"- **Durum:** {status}\n")
        
        if item["is_used"]:
            f.write(f"- **Nerelerde Çağrılıyor ({item['usage_count']} yer):**\n")
            for u in item["used_in"]:
                f.write(f"  - `{u}`\n")
            if item["usage_count"] > 5:
                f.write("  - ...ve daha fazlası\n")
                
        f.write("\n---\n\n")

print("Deep analysis complete. Check deep_report.md")
