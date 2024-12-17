@echo off
:: Animação pra deixar bonitin
cls
echo Iniciando Bakob - Ban chance reducer
echo.
for /l %%x in (1, 1, 3) do (
    set "dots="
    for /l %%y in (1, 1, %%x) do set "dots=!dots!."
    echo Carregando...
    timeout /t 1 >nul
)

:: Verifica se foi executado com administrador
openfiles >nul 2>nul
if %errorlevel% NEQ 0 (
    echo Este script precisa de permissao de administrador.
    echo Pressione qualquer tecla para reiniciar com permissao de administrador...
    pause >nul
    :: Reinicia o script com permissões de administrador
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)

setlocal enabledelayedexpansion

:: Define o caminho das pastas
set "robloxPath=%LOCALAPPDATA%\Roblox\logs"
set "crashesPath=%robloxPath%\crashes\reports"
set "archivePath=%crashesPath%\archive"

:: Verifica e deleta os arquivos .txt na pasta de logs
if exist "%robloxPath%" (
    echo Deletando arquivos .txt na pasta de logs...
    del /q "%robloxPath%\*.txt"
    echo Arquivos .txt apagados de "logs".
) else (
    echo A pasta de logs nao foi encontrada.
)

:: Verifica e deleta os arquivos na pasta de crashes
if exist "%crashesPath%" (
    echo Verificando arquivos .txt na pasta "crashes"...
    
    :: Verifica se existem arquivos .txt na pasta "crashes"
    set filesExist=false
    for %%F in (%crashesPath%\*.txt) do (
        set filesExist=true
    )

    if !filesExist! == true (
        echo Deletando arquivos .txt de "crashes"... 
        del /q "%crashesPath%\*.txt"
        echo Arquivos .txt apagados de "crashes".
    ) else (
        echo Nenhum arquivo .txt encontrado em "crashes". Pulando deleção.
    )
) else (
    echo A pasta "crashes" nao foi encontrada.
)

:: Verifica se há arquivos na pasta "archive"
if exist "%archivePath%" (
    set filesExist=false
    for %%F in (%archivePath%\*) do (
        set filesExist=true
    )

    :: Se houver arquivos na pasta "archive", pergunta se deseja deletá-los
    if !filesExist! == true (
        echo Ha arquivos dentro de "archive". Deseja deletar? (S/N)
        set /p userChoice=Escolha: 

        if /i "!userChoice!" == "S" (
            :: Deleta todos os arquivos dentro de "archive"
            del /q "%archivePath%\*.*"
            echo Arquivos apagados de "archive".
        ) else (
            echo Pulando a deleção dos arquivos em "archive".
        )
    ) else (
        echo Nenhum arquivo encontrado em "archive". Pulando.
    )
) else (
    echo A pasta "archive" nao foi encontrada.
)

echo Processo concluido com sucesso!
echo Pressione Enter para fechar.
pause >nul

endlocal
