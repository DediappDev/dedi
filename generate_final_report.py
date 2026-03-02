import os
import re

TARGET_DIR = '/Users/liberyus/development/dedi/lib'
ARTIFACT_PATH = '/Users/liberyus/.gemini/antigravity/brain/f40c4a04-9c8d-4698-9862-8fa1fac45df4/twake_analysis_report.md'

twake_linagora_regex = re.compile(r'(twake|linagora)', re.IGNORECASE)
fluffy_name_regex = re.compile(r'fluffy', re.IGNORECASE)
fluffy_content_regex = re.compile(r'fluffy', re.IGNORECASE)

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
        
        # We only care if:
        # 1. 'twake' or 'linagora' in name or content
        # 2. 'fluffy' in NAME (ignore fluffy in content to avoid 800+ fluffy imports)
        if twake_linagora_regex.search(file) or twake_linagora_regex.search(content) or fluffy_name_regex.search(file):
            files_to_analyze.append(filepath)

report = []

for filepath in files_to_analyze:
    relpath = os.path.relpath(filepath, '/Users/liberyus/development/dedi')
    filename = os.path.basename(filepath)
    content = all_dart_contents[filepath]
    
    # Check what matched
    matched_in_name = bool(twake_linagora_regex.search(filename) or fluffy_name_regex.search(filename))
    
    # Try to extract class name
    class_match = re.search(r'class\s+([a-zA-Z0-9_]+)', content)
    class_name = class_match.group(1) if class_match else "(Sınıf tanımlı değil)"
    
    # Heuristics for purpose
    purpose = "Uygulamanın genel akışında kullanılan bir dosya."
    if "twake_welcome" in relpath:
        purpose = "Twake'in eski giriş (login/welcome) ekranı arayüzü."
    elif "widgets/twake_components" in relpath:
        purpose = "Arayüzde gösterilen ortak bir Twake bileşeni (buton, loading vs.)."
    elif "domain/usecase/contacts" in relpath:
        purpose = "Telefon rehberi veya dış kaynaklardan kişi aramak/getirmek için kullanılan iş mantığı (API servisi çağrısı)."
    elif "event" in relpath:
        purpose = "Matrix protokolündeki özel Twake/Linagora mesaj türlerini çözümlemek veya göndermek."
    elif "app_grid" in relpath or "linagora_app" in filename:
        purpose = "Linagora / Twake ekosistemine ait 'App Grid' (mini uygulamalar) entegrasyonu için veri modeli veya mantığı."
    elif "twake_app.dart" in filename:
        purpose = "Uygulamanın ana Material App kökünü (DediApp vs) ayağa kaldıran ana UI dosyası."
    elif "fluffy" in filename.lower():
        purpose = "Fluffychat (eski isimlendirme) için oluşturulmuş bir dosya."
        
    import_path_str = f"package:fluffychat/{relpath[4:]}"
    usage_count = 0
    used_in = []
    
    for other_file, other_content in all_dart_contents.items():
        if other_file == filepath: continue
        if import_path_str in other_content or f"'{filename}'" in other_content or f'"{filename}"' in other_content:
            usage_count += 1
            other_rel = os.path.relpath(other_file, '/Users/liberyus/development/dedi')
            used_in.append(other_rel)
            
    report.append({
        "file": relpath,
        "class": class_name,
        "purpose": purpose,
        "is_used": usage_count > 0,
        "usage_count": usage_count,
        "used_in": used_in[:3],
        "matched_in_name": matched_in_name
    })

# Filter out the noise for the final report to make it readable.
# Prioritize files where twake/linagora/fluffy is actually in the NAME.
# If it's just in the content (like a copyright header or a random var), we group them or put them at the end.

name_matches = [r for r in report if r["matched_in_name"]]
content_matches = [r for r in report if not r["matched_in_name"]]

with open(ARTIFACT_PATH, 'w', encoding='utf-8') as f:
    f.write("# Twake, Linagora ve Fluffy Dosyaları Detaylı Analizi\n\n")
    f.write("> **Not:** Uygulamada içinde sadece `package:fluffychat` yazan 800'den fazla dosya olduğu için sadece **Twake**, **Linagora** ve isminde **Fluffy** geçen dosyalar filtrelenmiştir.\n\n")
    
    f.write("## 1. İsmi Orijinal Kalan Dosyalar (Adında twake, linagora veya fluffy geçenler)\n\n")
    f.write("Bu dosyaların isimleri eski projeden miras kalmıştır.\n\n")
    
    for item in sorted(name_matches, key=lambda x: not x["is_used"]):
        status = "🟢 AKTİF KULLANILIYOR" if item["is_used"] else "🔴 KULLANILMIYOR (SİLİNEBİLİR)"
        f.write(f"### `{item['file']}`\n")
        f.write(f"- **Ne İşe Yarar:** {item['purpose']}\n")
        f.write(f"- **Sınıf Adı:** `{item['class']}`\n")
        f.write(f"- **Durum:** {status}\n")
        if item["is_used"]:
            f.write(f"- **Nerelerde Çağrılıyor ({item['usage_count']} yerde):**\n")
            for u in item["used_in"]:
                f.write(f"  - `{u}`\n")
        f.write("\n")

    f.write("## 2. İçeriğinde Twake/Linagora Geçen Diğer Önemli Dosyalar\n\n")
    f.write("Bu dosyaların ismi farklı olsa da içlerinde Twake/Linagora referansları bulunmaktadır.\n\n")
    
    # We'll just list the used ones to save space, or summarize unused
    unused_content = [c for c in content_matches if not c["is_used"]]
    used_content = [c for c in content_matches if c["is_used"]]
    
    for item in sorted(used_content, key=lambda x: x["file"]):
        f.write(f"### `{item['file']}`\n")
        f.write(f"- **Ne İşe Yarar:** {item['purpose']}\n")
        f.write(f"- **Sınıf Adı:** `{item['class']}`\n")
        f.write(f"- **Durum:** 🟢 AKTİF KULLANILIYOR\n")
        f.write(f"- **Nerelerde Çağrılıyor ({item['usage_count']} yerde):**\n")
        for u in item["used_in"]:
            f.write(f"  - `{u}`\n")
        f.write("\n")
        
    f.write("## 3. Kullanılmayan ve İçeriğinde Twake/Linagora Geçen Dosyalar\n\n")
    for item in sorted(unused_content, key=lambda x: x["file"]):
        f.write(f"- **`{item['file']}`**: 🔴 KULLANILMIYOR (Silinebilir).\n")

print("Final report generated.")
