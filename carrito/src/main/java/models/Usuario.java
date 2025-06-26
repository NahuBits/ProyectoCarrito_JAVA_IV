package models;

import enums.TipoUsuario;

public class Usuario {

    private String nombreUsuario;
    private String password;
    private TipoUsuario tipo;
    private double saldo;

    public Usuario(String nombreUsuario, String password, TipoUsuario tipo) {
        this.nombreUsuario = nombreUsuario;
        this.password = password;
        this.tipo = tipo;
        this.saldo = 0;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public String getPassword() {
        return password;
    }

    public TipoUsuario getTipo() {
        return tipo;
    }
    
    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    public void agregarSaldo(double monto) {
        this.saldo += monto;
    }

    public boolean descontarSaldo(double monto) {
        if (this.saldo >= monto) {
            this.saldo -= monto;
            return true;
        }
        return false;
    }
}