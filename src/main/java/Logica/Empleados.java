/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Logica;

import Persistencia.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author manol
 */
public class Empleados implements InterfaceEmpleados {
    
    private int id;
    private String nombres;
    private String cedula;
    private String email;
    private String direccion;
    private String telefono;

    public Empleados(int id, String nombres, String cedula, String email, String direccion, String telefono) {
        this.id = id;
        this.nombres = nombres;
        this.cedula = cedula;
        this.email = email;
        this.direccion = direccion;
        this.telefono = telefono;
        
    }

    public Empleados(String nombres, String cedula, String email, String direccion, String telefono) {
        this.nombres = nombres;
        this.cedula = cedula;
        this.email = email;
        this.direccion = direccion;
        this.telefono = telefono;
    }

    public Empleados(int id) {
        this.id = id;
    }
    
    
    
    public Empleados(){
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    @Override
    public List<Empleados> listarEmpleados() {
        List<Empleados> listaEmpleados = new ArrayList<>();
        Conexion conexion = new Conexion();
        String sql = "SELECT * FROM datosempleados;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            Empleados e;
            while (rs.next()) {
                e = new Empleados();
                e.setId(rs.getInt("id"));
                e.setNombres(rs.getString("nombre"));
                e.setCedula(rs.getString("cedula"));
                e.setEmail(rs.getString("email"));
                e.setDireccion(rs.getString("direccion"));
                e.setTelefono(rs.getString("telefono"));
                
                listaEmpleados.add(e);
                
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return listaEmpleados;
    }
    
    @Override
     public Empleados getEmpleado() {
        String sql = "SELECT * FROM datosempleados WHERE id=" + this.id + ";";
        Conexion conexion = new Conexion();

        try {
            ResultSet rs = conexion.consultarBD(sql);
            if (rs.next()) {
                this.id = rs.getInt("id");
                this.nombres = rs.getString("nombre");
                this.nombres = rs.getString("nombres");
                this.email = rs.getString("email");
                this.direccion = rs.getString("direccion");
                this.telefono = rs.getString("telefono");
            }
        } catch (SQLException ex) {
        } finally {
            conexion.cerrarConexion();
        }
        return this;
    }
    
    @Override
    public boolean guardarEmpleados() {
    boolean exito = false;
    Conexion conexion = new Conexion();
    String sql = "INSERT INTO datosempleados (nombre, cedula, email, direccion, telefono) VALUES (?, ?, ?, ?, ?)";
    
    if (conexion.setAutoCommitBD(false)) {
        try {
            PreparedStatement pstmt = conexion.getConnection().prepareStatement(sql);
            pstmt.setString(1, this.nombres);
            pstmt.setString(2, this.cedula);
            pstmt.setString(3, this.email);
            pstmt.setString(4, this.direccion);
            pstmt.setString(5, this.telefono);

            if (pstmt.executeUpdate() > 0) {
                conexion.commitBD();
                exito = true;
            } else {
                conexion.rollbackBD();
            }
        } catch (SQLException ex) {
            System.out.println("Error al ejecutar la consulta SQL: " + ex.getMessage());
            conexion.rollbackBD();
        } finally {
            conexion.cerrarConexion();
        }
    } else {
        conexion.cerrarConexion();
    }
    return exito;
    }

    
    @Override
    public boolean actualizarEmpleado() {
        boolean exito = false;
        String sql = "UPDATE datosempleados SET nombre='" + this.nombres + "',cedula='" + this.cedula
                + "',email=" + this.email  + ",direccion=" + this.direccion + ",telefono=" + this.telefono
                + " "
                + "WHERE id=" + this.id + ";";
        Conexion conexion = new Conexion();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }
    
    @Override
    public boolean eliminarEmpleado() {
        boolean exito = false;
        String sql = "DELETE FROM datosempleados\n"
                + "WHERE id=" + this.id + ";";
        Conexion conexion = new Conexion();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(sql)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                exito = true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }

        return exito;
    }
          
}
