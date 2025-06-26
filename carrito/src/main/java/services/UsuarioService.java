package services;

import java.util.LinkedList;
import java.util.List;
import models.Usuario;
import enums.TipoUsuario;

public class UsuarioService {

    private static UsuarioService instancia;
    private List<Usuario> usuarios;

    private UsuarioService() {
        usuarios = new LinkedList<>();

        // Usuarios precargados
        usuarios.add(new Usuario("cliente1", "1234", TipoUsuario.CLIENTE));
        usuarios.add(new Usuario("cliente2", "1234", TipoUsuario.CLIENTE));
        usuarios.add(new Usuario("empleado1", "admin", TipoUsuario.EMPLEADO));
    }

    public static UsuarioService getInstance() {
        if (instancia == null) {
            instancia = new UsuarioService();
        }
        return instancia;
    }
    
    public List<Usuario> getUsuarios() {
        return usuarios;
    }

    public Usuario validar(String nombre, String pass) {
        return usuarios.stream()
                .filter(u -> u.getNombreUsuario().equals(nombre) && u.getPassword().equals(pass))
                .findFirst()
                .orElse(null);
    }
    public Usuario buscar(String nombreUsuario) {
        return usuarios.stream()
                .filter(u -> u.getNombreUsuario().equals(nombreUsuario))
                .findFirst()
                .orElse(null);
    }

}
