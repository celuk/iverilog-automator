#!/bin/bash

PWD_MAIN=`pwd`
cd "$PWD_MAIN";

# DIKKAT!
# vivadonun kabul ettigi ama iverilogun hata verdigi durumlar olabiliyor
# ornegin yaygin kullanilan soyle bir port tanimlamasi vivadoda calisirken iverilogda hatali kabul ediliyor:
# input [1:0] in1, in2
# iverilog hepsinin onune port direction istiyor yani su sekilde olmali:
# input [1:0] in1, input [1:0] in2
# bu yuzden buradan gecmeyenleri vivadoda bir kez daha kontrol etmeniz iyi olabilir

############################################# DEGISTIRMENIZ GEREKEN DEGISKENLER

IVERILOG_PATH="iverilog";

# Test edeceginiz moduller
# Birden fazla modulun ic ice kullanildigi bir soru icin tum modul isimlerini vermeniz gerekiyor.
# Ogrencinin modulu test edilecegi icin sadece modul ismi verilmeli, herhangi bir path'teki modul ismi degil.
VERILOG_MODULES="xor_karma.v isim_sifrele.v";

# Test edeceginiz testbench modulu
# Testbench ciktilarini gorebilmek icin $display komutunu kullanabilirsiniz
# ya da toplam dogru, yanlis sayisina bakarak toplam puani yine $display ile yazabilirsiniz,
# bu sizin yazdiginiz testbenche bagli ve komut ekranindaki ciktiyi buna gore goreceksiniz.
# Burada kendi yazdiginiz testbenchin path'ini vererek yazmalisiniz.
VERILOG_TB_MODULES="/home/shc/264odev1/tb_isim_sifrele.v";

IVERILOG_EXEC="tb_sim";

IVER_CMD="$IVERILOG_PATH $VERILOG_MODULES $VERILOG_TB_MODULES -o $IVERILOG_EXEC";

############################################# DEGISTIRMENIZ GEREKEN DEGISKENLERIN SONU

for file in *; do
    # Uzaktan indirilen her klasorde isim yaziyor, burada ismi basiyorum.
    echo "--------------------"; 
    echo $file | sed 's/_.*//';
    echo "--------------------";

    # O kisinin klasorune gidiyorum.
    cd "$file";
    
    # Klasorun icindeki zip ve rar dosyalarini buluyorum.
    zip_ext_arr=(`find ./ -maxdepth 1 -name "*.zip"`)
    rar_ext_arr=(`find ./ -maxdepth 1 -name "*.rar"`)
    
    # Eger klasorde zip ya da rar dosyalari varsa kontrolu
    # Burada tüm klasorlerde zip ya da rar oldugunu varsayiyorum.
    # BU IF EGER ZIP YA DA RARLI DOSYA GONDERIMI OLMADIYSA KALDIRILMALIDIR YA DA EKSTRA KONTROL KOYULABILIR
    if [[ ${#zip_ext_arr[@]} -gt 0 || ${#rar_ext_arr[@]} -gt 0 ]]; then
        # zip ya da rar varsa cikartiyorum.
        eval 'find . -type f -iname "*.zip" -exec unzip -q -o {} \;'
        eval 'find . -type f -iname "*.rar" -exec unrar -idq -o+ e {}  \;'

        # Klasorun icindeki verilog dosyalarini buluyorum.
        v_ext_arr=(`find ./ -maxdepth 1 -name "*.v"`)

        # Eger verilog kodlari bulunamadiysa;
        # tum ic ice zipleri, rarlari cikartmak da dahil olmak uzere 
        # bulana kadar, alt klasorler bitene kadar ya da hata verene kadar devam ediyorum.
        while [[ ${#v_ext_arr[@]} -eq 0 ]]; do
            pwd_subofsub=`pwd`;
            
            cd */ > /dev/null || true;
            eval 'find . -type f -iname "*.zip" -exec unzip -q -o {} \;'
            eval 'find . -type f -iname "*.rar" -exec unrar -idq -o+ e {}  \;'
            
            v_ext_arr=(`find ./ -maxdepth 1 -name "*.v"`)
            
            if [[ "$pwd_subofsub" == "`pwd`" ]]; then
                break;
            fi;
        done

        # Verilog kodlari varsa derle ve calistir
        if [[ ${#v_ext_arr[@]} -gt 0 ]]; then 
            eval "$IVER_CMD";
            echo `eval "./$IVERILOG_EXEC"`;
        fi;
    fi;
    echo "";
    cd "$PWD_MAIN";
done
