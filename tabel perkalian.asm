.model small
.stack 100h
.data
    msg db 'Tabel Perkalian 1', 0Dh, 0Ah, '$'
    newline db 0Dh, 0Ah, '$'
    
.code
main PROC
    ; Inisialisasi segmen data
    mov ax, @data
    mov ds, ax

    ; Tampilkan judul
    lea dx, msg
    mov ah, 09h
    int 21h

    ; Inisialisasi faktor pertama (1)
    mov bx,   

    ; Loop untuk faktor kedua (1 hingga 10)
    mov cx, 1          ; Faktor kedua dimulai dari 1

inner_loop:
    cmp cx, 10          ; Apakah cx > 9?
    ja end_program      ; Jika ya, keluar dari loop

    ; Tampilkan hasil dalam format: "1 x cx = hasil"
    mov ax, bx          ; Faktor pertama (1) ke AX
    mul cx              ; Perkalian: AX = BX * CX
    push ax             ; Simpan hasil perkalian

    ; Cetak faktor pertama
    mov ax, bx
    call print_number
    call print_space

    ; Cetak 'x'
    mov dl, 'x'
    mov ah, 02h
    int 21h
    call print_space

    ; Cetak faktor kedua
    mov ax, cx
    call print_number
    call print_space

    ; Cetak '='
    mov dl, '='
    mov ah, 02h
    int 21h
    call print_space

    ; Cetak hasil perkalian
    pop ax              ; Ambil kembali hasil perkalian
    call print_number
    call print_newline  ; Cetak baris baru

    inc cx              ; Faktor kedua +1
    jmp inner_loop      ; Ulangi untuk faktor kedua berikutnya

end_program:
    ; Akhiri program
    mov ax, 4C00h
    int 21h
main ENDP

; Subroutine untuk mencetak angka
print_number PROC
    push ax             ; Simpan nilai AX
    push bx             ; Simpan nilai BX
    push cx             ; Simpan nilai CX
    push dx             ; Simpan nilai DX

    xor cx, cx          ; Bersihkan CX
    mov bx, 10          ; Basis desimal

convert_loop:
    xor dx, dx          ; Bersihkan DX
    div bx              ; Bagi AX dengan BX, hasil di AX, sisa di DX
    push dx             ; Simpan sisa (digit)
    inc cx              ; Tambah jumlah digit
    cmp ax, 0
    jne convert_loop    ; Ulangi jika AX belum nol

print_digits:
    pop dx              ; Ambil digit dari stack
    add dl, '0'         ; Konversi ke ASCII
    mov ah, 02h
    int 21h             ; Cetak digit
    loop print_digits   ; Cetak semua digit

    pop dx              ; Pulihkan nilai DX
    pop cx              ; Pulihkan nilai CX
    pop bx              ; Pulihkan nilai BX
    pop ax              ; Pulihkan nilai AX
    ret
print_number ENDP

; Subroutine untuk mencetak spasi
print_space PROC
    mov dl, ' '
    mov ah, 02h
    int 21h
    ret
print_space ENDP

; Subroutine untuk mencetak baris baru
print_newline PROC
    lea dx, newline
    mov ah, 09h
    int 21h
    ret
print_newline ENDP

END main