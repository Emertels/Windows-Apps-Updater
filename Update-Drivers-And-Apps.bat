@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Windows Software Updater v1.0.0
rem Configura UTF-8 pela API do console para preservar acentos sem executar CHCP.
rem Define explicitamente peso de fonte normal (400) no console classico; ignora quando nao suportado.
powershell.exe -NoLogo -NoProfile -Command "[Console]::OutputEncoding=[Text.Encoding]::UTF8; [Console]::InputEncoding=[Text.Encoding]::UTF8; try { $src=[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('dXNpbmcgU3lzdGVtOwp1c2luZyBTeXN0ZW0uUnVudGltZS5JbnRlcm9wU2VydmljZXM7CnB1YmxpYyBzdGF0aWMgY2xhc3MgQ29uc29sZUZvbnRGaXgge1tTdHJ1Y3RMYXlvdXQoTGF5b3V0S2luZC5TZXF1ZW50aWFsKV0gcHVibGljIHN0cnVjdCBDIHsgcHVibGljIHNob3J0IFg7IHB1YmxpYyBzaG9ydCBZOyB9W1N0cnVjdExheW91dChMYXlvdXRLaW5kLlNlcXVlbnRpYWwsIENoYXJTZXQ9Q2hhclNldC5Vbmljb2RlKV0gcHVibGljIHN0cnVjdCBGIHsgcHVibGljIHVpbnQgY2JTaXplOyBwdWJsaWMgdWludCBuRm9udDsgcHVibGljIEMgc2l6ZTsgcHVibGljIHVpbnQgZmFtaWx5OyBwdWJsaWMgdWludCB3ZWlnaHQ7IFtNYXJzaGFsQXMoVW5tYW5hZ2VkVHlwZS5CeVZhbFRTdHIsIFNpemVDb25zdD0zMildIHB1YmxpYyBzdHJpbmcgZmFjZTsgfVtEbGxJbXBvcnQoImtlcm5lbDMyLmRsbCIpXSBzdGF0aWMgZXh0ZXJuIGJvb2wgU2V0Q29uc29sZU91dHB1dENQKHVpbnQgY3ApOw0KW0RsbEltcG9ydCgia2VybmVsMzIuZGxsIildIHN0YXRpYyBleHRlcm4gYm9vbCBTZXRDb25zb2xlQ1AodWludCBjcCk7DQpbRGxsSW1wb3J0KCJrZXJuZWwzMi5kbGwiKV0gc3RhdGljIGV4dGVybiBJbnRQdHIgR2V0U3RkSGFuZGxlKGludCBuKTtbRGxsSW1wb3J0KCJrZXJuZWwzMi5kbGwiKV0gc3RhdGljIGV4dGVybiBib29sIEdldEN1cnJlbnRDb25zb2xlRm9udEV4KEludFB0ciBoLCBib29sIG0sIHJlZiBGIGYpO1tEbGxJbXBvcnQoImtlcm5lbDMyLmRsbCIpXSBzdGF0aWMgZXh0ZXJuIGJvb2wgU2V0Q3VycmVudENvbnNvbGVGb250RXgoSW50UHRyIGgsIGJvb2wgbSwgcmVmIEYgZik7cHVibGljIHN0YXRpYyB2b2lkIE5vcm1hbCgpIHsgU2V0Q29uc29sZU91dHB1dENQKDY1MDAxKTsgU2V0Q29uc29sZUNQKDY1MDAxKTsgSW50UHRyIGg9R2V0U3RkSGFuZGxlKC0xMSk7IEYgZj1uZXcgRigpOyBmLmNiU2l6ZT0odWludClNYXJzaGFsLlNpemVPZih0eXBlb2YoRikpOyBpZihoPT1JbnRQdHIuWmVyb3x8aD09bmV3IEludFB0cigtMSl8fCFHZXRDdXJyZW50Q29uc29sZUZvbnRFeChoLGZhbHNlLHJlZiBmKSkgcmV0dXJuOyBmLndlaWdodD00MDA7IFNldEN1cnJlbnRDb25zb2xlRm9udEV4KGgsZmFsc2UscmVmIGYpOyB9fQ==')); Add-Type -TypeDefinition $src -ErrorAction Stop; [ConsoleFontFix]::Normal() } catch { }"
set "LANG=pt-BR"
set "UI_CULTURE="
for /f "delims=" %%A in ('powershell.exe -NoProfile -Command "[Globalization.CultureInfo]::CurrentUICulture.Name" 2^>nul') do set "UI_CULTURE=%%A"
if /i "%UI_CULTURE:~0,2%"=="en" set "LANG=en"
if /i "%UI_CULTURE:~0,2%"=="es" set "LANG=es"
if /i "%UI_CULTURE:~0,2%"=="fr" set "LANG=fr"
if /i "%UI_CULTURE:~0,2%"=="de" set "LANG=de"
if /i "%UI_CULTURE:~0,2%"=="it" set "LANG=it"
if /i "%UI_CULTURE:~0,2%"=="ja" set "LANG=ja"
if /i "%UI_CULTURE:~0,2%"=="ko" set "LANG=ko"
if /i "%UI_CULTURE:~0,5%"=="zh-CN" set "LANG=zh-CN"
if /i "%UI_CULTURE:~0,2%"=="ru" set "LANG=ru"
call :SetLanguage
color 02
set "SESSION_TIME=%date% %time:~0,8%"

cls
echo %TITLE_TEXT%
echo ======================================================================
echo %VERSION_LABEL%: 1.0.0
echo %SESSION_LABEL%: %SESSION_TIME%
echo %LANGUAGE_LABEL%: %LANG% (%UI_CULTURE%)
echo ======================================================================
echo %SCOPE_NOTE%
echo.

where.exe winget.exe >nul 2>&1
if errorlevel 1 goto :WingetMissing

echo %START_NOTE%
echo.
winget.exe upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements
set "WINGET_CODE=%ERRORLEVEL%"
echo.
echo %RESULT_LABEL%: %WINGET_CODE%
if "%WINGET_CODE%"=="0" (echo %SUCCESS_NOTE%) else (echo %FAILURE_NOTE%)
echo %CLOSE_NOTE%
pause >nul
exit /b %WINGET_CODE%

:WingetMissing
echo %MISSING_NOTE%
echo %CLOSE_NOTE%
pause >nul
exit /b 1

:SetLanguage
set "TITLE_TEXT=ATUALIZADOR DE PROGRAMAS DO WINDOWS"
set "VERSION_LABEL=Versão"
set "SESSION_LABEL=Sessão iniciada"
set "LANGUAGE_LABEL=Idioma detectado"
set "SCOPE_NOTE=Atualiza aplicativos gerenciados pelo winget; não instala drivers de hardware."
set "START_NOTE=Buscando e instalando atualizações disponíveis..."
set "RESULT_LABEL=Código de saída do winget"
set "SUCCESS_NOTE=Processo concluído. Revise acima se algum pacote exigiu ação manual."
set "FAILURE_NOTE=O winget relatou falhas ou pacotes que exigem verificação."
set "MISSING_NOTE=winget não foi encontrado. Instale o Instalador de Aplicativo pela Microsoft Store."
set "CLOSE_NOTE=Pressione uma tecla para fechar."
if /i "%LANG%"=="en" (
 set "TITLE_TEXT=WINDOWS SOFTWARE UPDATER"
 set "VERSION_LABEL=Version"
 set "SESSION_LABEL=Session started"
 set "LANGUAGE_LABEL=Detected language"
 set "SCOPE_NOTE=Updates winget-managed apps; it does not install hardware drivers."
 set "START_NOTE=Checking for and installing available updates..."
 set "RESULT_LABEL=winget exit code"
 set "SUCCESS_NOTE=Process complete. Check above for packages that need manual action."
 set "FAILURE_NOTE=winget reported failures or packages that need review."
 set "MISSING_NOTE=winget was not found. Install App Installer from Microsoft Store."
 set "CLOSE_NOTE=Press any key to close."
)
if /i "%LANG%"=="es" (
 set "TITLE_TEXT=ACTUALIZADOR DE PROGRAMAS DE WINDOWS"
 set "VERSION_LABEL=Versión"
 set "SESSION_LABEL=Sesión iniciada"
 set "LANGUAGE_LABEL=Idioma detectado"
 set "SCOPE_NOTE=Actualiza aplicaciones de winget; no instala controladores de hardware."
 set "START_NOTE=Buscando e instalando actualizaciones disponibles..."
 set "RESULT_LABEL=Código de salida de winget"
 set "SUCCESS_NOTE=Proceso finalizado. Revise los paquetes que requieran acción manual."
 set "FAILURE_NOTE=winget informó errores o paquetes que requieren revisión."
 set "MISSING_NOTE=No se encontró winget. Instale Instalador de aplicaciones desde Microsoft Store."
 set "CLOSE_NOTE=Pulse una tecla para cerrar."
)
if /i "%LANG%"=="fr" (
 set "TITLE_TEXT=MISE À JOUR DES PROGRAMMES WINDOWS"
 set "VERSION_LABEL=Version"
 set "SESSION_LABEL=Session démarrée"
 set "LANGUAGE_LABEL=Langue détectée"
 set "SCOPE_NOTE=Met à jour les applications winget, sans installer les pilotes matériels."
 set "START_NOTE=Recherche et installation des mises à jour disponibles..."
 set "RESULT_LABEL=Code de sortie winget"
 set "SUCCESS_NOTE=Opération terminée. Vérifiez les paquets nécessitant une intervention manuelle."
 set "FAILURE_NOTE=winget a signalé des échecs ou des paquets à vérifier."
 set "MISSING_NOTE=winget est introuvable. Installez App Installer depuis Microsoft Store."
 set "CLOSE_NOTE=Appuyez sur une touche pour fermer."
)
if /i "%LANG%"=="de" (
 set "TITLE_TEXT=WINDOWS-PROGRAMM-UPDATER"
 set "VERSION_LABEL=Version"
 set "SESSION_LABEL=Sitzung gestartet"
 set "LANGUAGE_LABEL=Erkannte Sprache"
 set "SCOPE_NOTE=Aktualisiert winget-Apps, installiert jedoch keine Hardwaretreiber."
 set "START_NOTE=Verfügbare Updates werden gesucht und installiert..."
 set "RESULT_LABEL=winget-Rückgabecode"
 set "SUCCESS_NOTE=Vorgang abgeschlossen. Pakete mit manueller Aktion oben prüfen."
 set "FAILURE_NOTE=winget meldet Fehler oder zu prüfende Pakete."
 set "MISSING_NOTE=winget nicht gefunden. App-Installer aus dem Microsoft Store installieren."
 set "CLOSE_NOTE=Beliebige Taste zum Schließen drücken."
)
if /i "%LANG%"=="it" (
 set "TITLE_TEXT=AGGIORNAMENTO PROGRAMMI WINDOWS"
 set "VERSION_LABEL=Versione"
 set "SESSION_LABEL=Sessione avviata"
 set "LANGUAGE_LABEL=Lingua rilevata"
 set "SCOPE_NOTE=Aggiorna le app gestite da winget, non installa driver hardware."
 set "START_NOTE=Ricerca e installazione degli aggiornamenti disponibili..."
 set "RESULT_LABEL=Codice di uscita winget"
 set "SUCCESS_NOTE=Operazione completata. Controlla i pacchetti che richiedono intervento manuale."
 set "FAILURE_NOTE=winget ha segnalato errori o pacchetti da verificare."
 set "MISSING_NOTE=winget non trovato. Installa App Installer da Microsoft Store."
 set "CLOSE_NOTE=Premi un tasto per chiudere."
)
if /i "%LANG%"=="ja" (
 set "TITLE_TEXT=Windows アプリ更新ツール"
 set "VERSION_LABEL=バージョン"
 set "SESSION_LABEL=セッション開始"
 set "LANGUAGE_LABEL=検出された言語"
 set "SCOPE_NOTE=winget 管理アプリを更新します。ハードウェア ドライバーは更新しません。"
 set "START_NOTE=利用可能な更新を確認してインストールしています..."
 set "RESULT_LABEL=winget 終了コード"
 set "SUCCESS_NOTE=完了しました。手動操作が必要なパッケージを確認してください。"
 set "FAILURE_NOTE=winget が失敗または確認が必要なパッケージを報告しました。"
 set "MISSING_NOTE=winget が見つかりません。Microsoft Store からアプリ インストーラーを入手してください。"
 set "CLOSE_NOTE=何かキーを押して閉じます。"
)
if /i "%LANG%"=="ko" (
 set "TITLE_TEXT=Windows 앱 업데이트 도구"
 set "VERSION_LABEL=버전"
 set "SESSION_LABEL=세션 시작"
 set "LANGUAGE_LABEL=감지된 언어"
 set "SCOPE_NOTE=winget 앱을 업데이트하며 하드웨어 드라이버는 설치하지 않습니다."
 set "START_NOTE=사용 가능한 업데이트를 확인하고 설치하는 중..."
 set "RESULT_LABEL=winget 종료 코드"
 set "SUCCESS_NOTE=완료되었습니다. 수동 작업이 필요한 패키지를 확인하세요."
 set "FAILURE_NOTE=winget에서 실패했거나 확인이 필요한 패키지를 보고했습니다."
 set "MISSING_NOTE=winget을 찾을 수 없습니다. Microsoft Store에서 앱 설치 관리자를 설치하세요."
 set "CLOSE_NOTE=아무 키나 눌러 닫으세요."
)
if /i "%LANG%"=="zh-CN" (
 set "TITLE_TEXT=Windows 软件更新工具"
 set "VERSION_LABEL=版本"
 set "SESSION_LABEL=会话开始时间"
 set "LANGUAGE_LABEL=检测到的语言"
 set "SCOPE_NOTE=更新由 winget 管理的应用；不会安装硬件驱动。"
 set "START_NOTE=正在检查并安装可用更新..."
 set "RESULT_LABEL=winget 退出代码"
 set "SUCCESS_NOTE=已完成。请检查是否有需要手动操作的软件包。"
 set "FAILURE_NOTE=winget 报告了失败项或需要检查的软件包。"
 set "MISSING_NOTE=未找到 winget。请从 Microsoft Store 安装应用安装程序。"
 set "CLOSE_NOTE=按任意键关闭。"
)
if /i "%LANG%"=="ru" (
 set "TITLE_TEXT=ОБНОВЛЕНИЕ ПРИЛОЖЕНИЙ WINDOWS"
 set "VERSION_LABEL=Версия"
 set "SESSION_LABEL=Сеанс начат"
 set "LANGUAGE_LABEL=Обнаруженный язык"
 set "SCOPE_NOTE=Обновляет приложения winget, но не устанавливает драйверы оборудования."
 set "START_NOTE=Поиск и установка доступных обновлений..."
 set "RESULT_LABEL=Код завершения winget"
 set "SUCCESS_NOTE=Готово. Проверьте пакеты, которым требуется действие вручную."
 set "FAILURE_NOTE=winget сообщил об ошибках или пакетах для проверки."
 set "MISSING_NOTE=winget не найден. Установите App Installer из Microsoft Store."
 set "CLOSE_NOTE=Нажмите любую клавишу, чтобы закрыть окно."
)
exit /b
