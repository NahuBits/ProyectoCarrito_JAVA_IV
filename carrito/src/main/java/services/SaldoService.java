package services;

import java.util.Map;

import models.Usuario;

public class SaldoService {
	private Map<String, Usuario> usuarios;

	public SaldoService(Map<String, Usuario> usuarios) {
	    this.usuarios = usuarios;
	}

	public void agregarSaldo(Usuario usuario, double monto) {
	    usuario.agregarSaldo(monto);
	}

	public boolean transferir(String origenUsername, String destinoUsername, double monto) {
	    Usuario origen = usuarios.get(origenUsername);
	    Usuario destino = usuarios.get(destinoUsername);

	    if (origen != null && destino != null && origen.getSaldo() >= monto) {
	        origen.descontarSaldo(monto);
	        destino.agregarSaldo(monto);
	        return true;
	    }
	    return false;
	}

	public boolean descontarPorCompra(Usuario usuario, double total) {
	    return usuario.descontarSaldo(total);
	}
	
}
