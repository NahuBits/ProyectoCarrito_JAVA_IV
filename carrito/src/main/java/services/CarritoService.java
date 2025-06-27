package services;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import models.Articulo;
import models.Compra;
import models.DetalleCompra;
import models.Usuario;

public class CarritoService {
    private List<DetalleCompra> carrito = new ArrayList<>();
    private List<Compra> historial = new ArrayList<>();

    public void agregarArticulo(Articulo a, int cantidad) {
        if (a.getStock() < cantidad) {
            throw new RuntimeException("Stock insuficiente");
        }

        for (DetalleCompra d : carrito) {
            if (d.getArticulo().getCodigo() == a.getCodigo()) {
                d.setCantidad(d.getCantidad() + cantidad);
                a.setStock(a.getStock() - cantidad);
                return;
            }
        }

        a.setStock(a.getStock() - cantidad);
        carrito.add(new DetalleCompra(a, cantidad));
    }

    public void eliminarDelCarrito(long codigoArticulo) {
        Iterator<DetalleCompra> iter = carrito.iterator();
        while (iter.hasNext()) {
            DetalleCompra d = iter.next();
            if (d.getArticulo().getCodigo() == codigoArticulo) {
                d.getArticulo().setStock(d.getArticulo().getStock() + d.getCantidad());
                iter.remove();
                break;
            }
        }
    }

    public void restaurarStockCarrito() {
        for (DetalleCompra d : carrito) {
            d.getArticulo().setStock(d.getArticulo().getStock() + d.getCantidad());
        }
        carrito.clear();
    }

    public List<DetalleCompra> getCarrito() {
        return carrito;
    }

    public double getTotal() {
        return carrito.stream().mapToDouble(DetalleCompra::getSubtotal).sum();
    }

    public void finalizarCompra(Usuario usuario) {
        double total = getTotal();

        if (!usuario.descontarSaldo(total)) {
            throw new RuntimeException("Saldo insuficiente.");
        }

        Compra compra = new Compra(usuario);
        for (DetalleCompra d : carrito) {
            compra.agregarDetalle(d);
            
        }
        historial.add(compra);
        carrito.clear();
    }

    public List<Compra> getHistorial(Usuario usuario) {
        return historial.stream()
                .filter(c -> c.getCliente().getNombreUsuario().equals(usuario.getNombreUsuario()))
                .toList();
    }
    public List<Compra> getHistorialCompleto() {
    	return new ArrayList<>(historial);
    	}
    public List<Compra> getHistorialFiltradoPorUsuario(String nombreUsuario) {
    	return historial.stream()
    	.filter(c -> c.getCliente().getNombreUsuario().toLowerCase().contains(nombreUsuario.toLowerCase()))
    	.toList();
    	}
    public Compra getCompraPorId(long id) {
        return historial.stream().filter(c -> c.getId() == id).findFirst().orElse(null);
    }
}
