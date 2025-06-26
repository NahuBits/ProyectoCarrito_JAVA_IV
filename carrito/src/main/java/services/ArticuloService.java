package services;

import models.Articulo;
import java.util.*;

public class ArticuloService {
    private static ArticuloService instancia;
    private List<Articulo> articulos;
    private long ultimoCodigo = 4; //4 art�culos de muestra

    private ArticuloService() {
        articulos = new ArrayList<>();
        // Carga inicial opcional
        articulos.add(new Articulo(1, "Camiseta", 2500.00, 10));
        articulos.add(new Articulo(2, "Pantalon", 0.00, 5));
        articulos.add(new Articulo(3, "Zapatilla", 8500.00, 20));
        articulos.add(new Articulo(4, "Campera", 6500.00, 50));
    }

    public static ArticuloService getInstance() {
        if (instancia == null) {
            instancia = new ArticuloService();
        }
        return instancia;
    }

    public List<Articulo> obtenerTodos() {
        return List.copyOf(articulos);
    }


    public void agregar(Articulo art) {
    if (art.getCodigo() <= 0) {
    ultimoCodigo++;
    art.setCodigo(ultimoCodigo);
    }
    articulos.add(art);
    }

    public void actualizar(Articulo art) {
        for (int i = 0; i < articulos.size(); i++) {
            if (articulos.get(i).getCodigo() == art.getCodigo()) {
                articulos.set(i, art); // reemplaza el existente
                return;
            }
        }
        articulos.add(art); // si no estaba, lo agrega
    }

    public void eliminar(long codigo) {
        articulos.removeIf(a -> a.getCodigo() == codigo);
    }

    public Articulo buscarPorCodigo(long codigo) {
        return articulos.stream()
                .filter(a -> a.getCodigo() == codigo)
                .findFirst()
                .orElse(null);
    }
}