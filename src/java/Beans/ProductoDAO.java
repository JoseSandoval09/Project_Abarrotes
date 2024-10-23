package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Producto;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.HibernateException;

public class ProductoDAO {

    private Session sesion = null;
    private Transaction tx = null;

    public int guardaProducto(Mapeos.Producto producto) throws HibernateException {
        int id = -1;

        try {
            iniciaOperacion();
            id = (Integer) sesion.save(producto);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return id;
    }

    public void eliminaProducto(int ProductoNo) {
        try {
            iniciaOperacion();
            Producto producto = (Producto) sesion.get(Producto.class, ProductoNo);
            sesion.delete(producto);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
    }

    public Producto obtenProducto(int NoProducto) throws HibernateException {
        Producto producto = null;
        try {
            iniciaOperacion();
            producto = (Producto) sesion.get(Producto.class, NoProducto);
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return producto;
    }

    public List<Producto> obtenListaProducto() throws HibernateException {
        List<Producto> Productos = null;
        try {
            iniciaOperacion();
            Productos = sesion.createQuery("from Producto").list();
            System.out.print("Se tiene la lista");
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return Productos;
    }

    public int actualizaProducto(Mapeos.Producto producto) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(producto);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            if (sesion != null) {
                sesion.close();
            }
        }
        return 0;
    }

    private void iniciaOperacion() throws HibernateException {
        sesion = HibernateUtil.getSessionFactory().openSession();
        tx = sesion.beginTransaction();
    }

    private void manejaExcepcion(HibernateException he) throws HibernateException {
        if (tx != null) {
            tx.rollback();
        }
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }
}