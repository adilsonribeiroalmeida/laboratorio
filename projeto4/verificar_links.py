import os
from bs4 import BeautifulSoup
from urllib.parse import urlparse, unquote

# Diretório onde está o script
diretorio = os.path.dirname(os.path.abspath(__file__))

# Lista todos os arquivos HTML do diretório
arquivos_html = [
    arquivo
    for arquivo in os.listdir(diretorio)
    if arquivo.lower().endswith(".html")
]

print(f"Arquivos HTML encontrados: {len(arquivos_html)}\n")

problemas = 0

for arquivo_html in arquivos_html:

    caminho_arquivo = os.path.join(diretorio, arquivo_html)

    with open(caminho_arquivo, "r", encoding="utf-8", errors="ignore") as arquivo:
        soup = BeautifulSoup(arquivo, "html.parser")

    links = soup.find_all("a")

    for link in links:

        href = link.get("href")

        # href inexistente ou vazio
        if href is None or href.strip() == "":
            print(f"[HREF VAZIO] {arquivo_html}")
            problemas += 1
            continue

        href = href.strip()

        # Ignora âncoras internas
        if href.startswith("#"):
            continue

        # Ignora alguns protocolos
        if href.lower().startswith((
            "http://",
            "https://",
            "mailto:",
            "tel:",
            "javascript:"
        )):
            continue

        # Remove ?query e #anchor
        caminho_link = urlparse(href).path
        caminho_link = unquote(caminho_link)

        # Verifica apenas links HTML
        if caminho_link.lower().endswith((".html", ".htm")):

            caminho_destino = os.path.join(
                diretorio,
                caminho_link
            )

            caminho_destino = os.path.normpath(caminho_destino)

            if not os.path.isfile(caminho_destino):
                print(
                    f"[ARQUIVO NÃO ENCONTRADO] "
                    f"{arquivo_html} -> {href}"
                )
                problemas += 1


print("\n-----------------------------")

if problemas == 0:
    print("Nenhum problema encontrado.")
else:
    print(f"{problemas} problema(s) encontrado(s).")