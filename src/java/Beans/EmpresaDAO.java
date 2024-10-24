/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Empresa;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 * DAO para la entidad Empresa.
 * Gestiona las operaciones CRUD usando Hibernate.
 * 
 * @author 
 */
public class EmpresaDAO {
    private Session sesion;
    private Transaction tx;

    // Método para guardar una nueva Empresa en la base de datos
    public int guardarEmpresa(Empresa empresa) throws HibernateException {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(empresa);  // Guardar la empresa y obtener su ID
            tx.commit();  // Confirmar la transacción
        } catch (HibernateException he) {
            manejaExcepcion(he);  // Manejar excepciones de Hibernate
            throw he;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.close();  // Cerrar la sesión de Hibernate
        }
        return id;
    }

    // Método para eliminar una empresa por su ID
    public void eliminaEmpresa(int idEmpresa) {
        try {
            iniciaOperacion();
            Empresa empresa = (Empresa) sesion.get(Empresa.class, idEmpresa);  // Obtener la empresa
            if (empresa != null) {
                sesion.delete(empresa);  // Eliminar la empresa
                tx.commit();  // Confirmar la transacción
            }
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            sesion.close();
        }
    }

    // Método para obtener una empresa por su ID
    public Empresa obtenEmpresa(int idEmpresa) throws HibernateException {
        Empresa empresa = null;
        try {
            iniciaOperacion();
            empresa = (Empresa) sesion.get(Empresa.class, idEmpresa);  // Obtener la empresa por su ID
        } finally {
            sesion.close();  // Cerrar la sesión
        }
        return empresa;
    }

    // Método para obtener una lista de todas las empresas
    public List<Empresa> obtenListaEmpresas() throws HibernateException {
        List<Empresa> listaEmpresas = null;
        try {
            iniciaOperacion();
            listaEmpresas = sesion.createQuery("from Empresa").list();  // Consultar todas las empresas
        } finally {
            sesion.close();
        }
        return listaEmpresas;
    }

    // Método para actualizar una empresa existente
    public void actualizaEmpresa(Empresa empresa) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(empresa);  // Actualizar la empresa
            tx.commit();  // Confirmar la transacción
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
    }

    // Método auxiliar para iniciar una operación con Hibernate
    private void iniciaOperacion() {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();  // Abrir sesión
            tx = sesion.beginTransaction();  // Iniciar transacción
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    // Maneja las excepciones de Hibernate
    private void manejaExcepcion(HibernateException he) throws HibernateException {
        if (tx != null) tx.rollback();  // Revertir la transacción en caso de error
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }
}
