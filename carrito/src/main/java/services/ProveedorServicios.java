package services;

import java.util.HashMap;
import java.util.Map;

import models.Usuario;

public class ProveedorServicios {

	private static ProveedorServicios singleton;
	private SaldoService saldoService;
	
	private ProveedorServicios() {
		UsuarioService usuarioService = UsuarioService.getInstance();
		// Crear un mapa a partir de los usuarios existentes
	    Map<String, Usuario> usuariosMap = new HashMap<>();
	    for (Usuario u : usuarioService.getUsuarios()) {
	        usuariosMap.put(u.getNombreUsuario(), u);
	    }
        // Aquí deberías cargar los usuarios existentes o pasar tu repositorio
        saldoService = new SaldoService(usuariosMap);
    }
	
    public static ProveedorServicios getInstance() {
        if (singleton == null) singleton = new ProveedorServicios();
        return singleton;
    }
    
    public UsuarioService getUsuarioService() {
        return UsuarioService.getInstance();
    }
    
     public ArticuloService getArticuloService() {
        return ArticuloService.getInstance();
    }

    public CarritoService getCarritoService() {
        return CarritoServiceSingleton.getInstance();
    }
    
    public SaldoService getSaldoService() {
    	return saldoService;
    }
    
}