/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Logica;

import java.util.List;

/**
 *
 * @author manol
 */
public interface InterfaceEmpleados {
        public List<Empleados> listarEmpleados();
        public boolean guardarEmpleados();
        public boolean actualizarEmpleado();
        public boolean eliminarEmpleado();
        public Empleados getEmpleado();
        
}
