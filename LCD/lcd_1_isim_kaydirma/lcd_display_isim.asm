	LIST P=16F877A
	#INCLUDE <P16F877A.INC>
	TEMP EQU 0X20
	DEGER EQU 0X21
	DEGER2 EQU 0X22
	SUTUN EQU 0X23
	SAYAC EQU 0X24
	SUTUN2 EQU 0X25
	SATIR2_SAYAC EQU 0X26
	KONTROL EQU 0X27
	ORG 0X00
	GOTO MAIN
MAIN
	BANKSEL TRISB
	CLRF TRISB
	BANKSEL PORTB
	CLRF PORTB
	MOVLW 0X80
	MOVWF SUTUN
	MOVLW 0X0C
	MOVWF SAYAC
	MOVLW 0XC0
	MOVWF SUTUN2
	MOVLW 0X0F
	MOVWF SATIR2_SAYAC
	CLRF KONTROL
	CALL TEMIZLE
LOOP
	DECFSZ SAYAC,F
	GOTO ILERI
	MOVLW 0X0C
	MOVWF SAYAC
	GOTO GERI
ILERI
	INCF SUTUN,F
	GOTO D1
GERI
	DECF SUTUN,F
	GOTO D2
D1	
	MOVLW 0X01
	CALL KOMUT_YAZ
	MOVF SUTUN,W
	CALL KOMUT_YAZ
	CALL KARAKTER_GIR
	CALL GECIKME2
	GOTO LOOP
D2
	MOVLW 0X01
	CALL KOMUT_YAZ
	MOVF SUTUN,W
	CALL KOMUT_YAZ
	CALL KARAKTER_GIR
	CALL GECIKME2
	DECFSZ SAYAC,F
	GOTO GERI
	MOVLW 0X0C
	MOVWF SAYAC
	GOTO ILERI
TEMIZLE
	MOVLW 0X02
	CALL KOMUT_YAZ
	MOVLW 0X01
	CALL KOMUT_YAZ
	MOVLW 0X0C
	CALL KOMUT_YAZ
	MOVLW 0X28
	CALL KOMUT_YAZ
	MOVLW 0X80
	CALL KOMUT_YAZ
	RETURN
KOMUT_YAZ
	MOVWF TEMP
	SWAPF TEMP,W
	CALL KOMUT_GONDER
	MOVF TEMP,W
	CALL KOMUT_GONDER
	RETURN

KOMUT_GONDER
	ANDLW 0X0F
	BANKSEL PORTB
	MOVWF PORTB
	BCF PORTB,4
	BSF PORTB,5
	CALL GECIKME
	BCF PORTB,5
	RETURN
KARAKTER_GIR
	MOVLW 'Y'
	CALL KARAKTER_YAZ
	MOVLW 'U'
	CALL KARAKTER_YAZ
	MOVLW 'C'
	CALL KARAKTER_YAZ
	MOVLW 'E'
	CALL KARAKTER_YAZ
	MOVLW 'L'
	CALL KARAKTER_YAZ
	CALL SATIR2
	MOVLW 'A'
	CALL KARAKTER_YAZ
	MOVLW 'Y'
	CALL KARAKTER_YAZ
	RETURN
SATIR2
	DECFSZ SATIR2_SAYAC,F
	GOTO D8
	MOVLW 0X0F
	XORWF KONTROL,F
	MOVLW 0X0E
	MOVWF SATIR2_SAYAC
D8
	BTFSS KONTROL,0
	GOTO SATIR2_ILERI
	GOTO SATIR2_GERI
SATIR2_ILERI
	INCF SUTUN2,F
	MOVF SUTUN2,W
	CALL KOMUT_YAZ
	RETURN
SATIR2_GERI
	DECF SUTUN2,F
	MOVF SUTUN2,W
	CALL KOMUT_YAZ
	RETURN
KARAKTER_YAZ
	MOVWF TEMP
	SWAPF TEMP,W
	CALL KARAKTER_GONDER
	MOVF TEMP,W
	CALL KARAKTER_GONDER
	RETURN
KARAKTER_GONDER
	ANDLW 0X0F
	MOVWF PORTB
	BANKSEL PORTB
	BSF PORTB,4
	BSF PORTB,5
	CALL GECIKME
	BCF PORTB,5
	RETURN
GECIKME2
	MOVLW 0XFF
	MOVWF DEGER
	GOTO DONGU
GECIKME
	MOVLW 0X04
	MOVWF DEGER
DONGU
	MOVLW 0XFF
	MOVWF DEGER2
DONGU2
	DECFSZ DEGER2,F
	GOTO DONGU2
	DECFSZ DEGER,F
	GOTO DONGU
	RETURN
END