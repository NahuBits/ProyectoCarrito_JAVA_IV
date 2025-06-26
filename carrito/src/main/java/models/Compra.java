package models;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Compra {
    private static long ultimaId = 1;
    private long id;
    private Usuario cliente;
    private LocalDateTime fecha;
    private List<DetalleCompra> detalles = new ArrayList<>();

    public Compra(Usuario cliente) {
        this.id = ultimaId++;
        this.cliente = cliente;
        this.fecha = LocalDateTime.now();
    }

    public void agregarDetalle(DetalleCompra detalle) {
        detalles.add(detalle);
    }

    public long getId() {
        return id;
    }

    public Usuario getCliente() {
        return cliente;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public List<DetalleCompra> getDetalles() {
        return detalles;
    }

    public double getTotal() {
        return detalles.stream().mapToDouble(DetalleCompra::getSubtotal).sum();
    }
}

