package services;

public class CarritoServiceSingleton {
    private static CarritoService instance;

    public static CarritoService getInstance() {
        if (instance == null) instance = new CarritoService();
        return instance;
    }
}
