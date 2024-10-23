package Beans;

import Hibernate.HibernateUtil;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import Mapeos.Empleado;

public class EmpleadoDAO {

    private Session sesion;
    private Transaction tx;

    public int guardaEmpleado(Mapeos.Empleado empleado) throws HibernateException {
        int id = -1;

        try {
            iniciaOperacion();
            id = (Integer) sesion.save(empleado);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.close();
        }
        return id;
    }

    public void eliminaEmpleado(int EmpleadoNo) {
        try {
            iniciaOperacion();
            Empleado empleado = (Empleado) sesion.get(Empleado.class, EmpleadoNo);
            sesion.delete(empleado);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            sesion.close();
        }
    }

    public Empleado obtenEmpleado(int NoEmpleado) throws HibernateException {
        Empleado empleado = null;
        try {
            iniciaOperacion();
            empleado = (Empleado) sesion.get(Empleado.class, NoEmpleado);
        } finally {
            sesion.close();
        }
        return empleado;
    }

    public List<Empleado> obtenListaEmpleado() throws HibernateException {
        List<Empleado> listaEmpleados = null;

        try {
            iniciaOperacion();
            listaEmpleados = sesion.createQuery("from Empleado").list();
        } finally {
            sesion.close();
        }
        return listaEmpleados;
    }

public void actualizaEmpleado(int EmpleadoNo, Empleado nuevoEmpleado) throws HibernateException {
    try {
        iniciaOperacion();
        Empleado empleado = (Empleado) sesion.get(Empleado.class, EmpleadoNo);
        
        // Actualiza los atributos del empleado
        if (empleado != null) {
            empleado.setNombreEmpleado(nuevoEmpleado.getNombreEmpleado());
            empleado.setApellPatEmpleado(nuevoEmpleado.getApellPatEmpleado());
            empleado.setApellMatEmpleado(nuevoEmpleado.getApellMatEmpleado());
            empleado.setPassword(nuevoEmpleado.getPassword());
            empleado.setFechaNac(nuevoEmpleado.getFechaNac());
            empleado.setRfce(nuevoEmpleado.getRfce());
            empleado.setSalario(nuevoEmpleado.getSalario());
            empleado.setEstadoCivil(nuevoEmpleado.getEstadoCivil());
            empleado.setEstatus(nuevoEmpleado.getEstatus());
            empleado.setNivelEstudio(nuevoEmpleado.getNivelEstudio());
            empleado.setTipoUsuario(nuevoEmpleado.getTipoUsuario());

            // Realiza la actualización
            sesion.update(empleado);
            tx.commit();
        }
    } catch (HibernateException he) {
        manejaExcepcion(he);
        throw he;
    } finally {
        sesion.close();
    }
}


    /* forma de actualizar 2 */
//    public void updateEmpleado(Integer NoEmpleado, String NombreEmpleado) {
//        iniciaOperacion();
//        try {
//            Empleado empleado =
//                    (Empleado) sesion.get(Empleado.class, NoEmpleado);
//            Empleado.setFirstName(nombre);
//            sesion.update(empleado);
//            tx.commit();
//        } catch (HibernateException he) {
//            manejaExcepcion(he);
//        } finally {
//            sesion.close();
//        }
//    }

    private void iniciaOperacion(){
       try{
           
       
        sesion = HibernateUtil.getSessionFactory().openSession();
        tx = sesion.beginTransaction();
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private void manejaExcepcion(HibernateException he) throws HibernateException {
        tx.rollback();
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }
}