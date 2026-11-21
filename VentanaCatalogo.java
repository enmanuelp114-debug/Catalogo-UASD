/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package catalogouasd;


public class VentanaCatalogo extends javax.swing.JFrame {
private javax.swing.JComboBox<String> cmbFacultad;
private javax.swing.JComboBox<String> cmbEscuela;
private javax.swing.JTable tblCarreras;
private javax.swing.table.DefaultTableModel modelo;    
    private static final java.util.logging.Logger logger = java.util.logging.Logger.getLogger(VentanaCatalogo.class.getName());

    
    public VentanaCatalogo() {
    initComponents();
    construirInterfaz();
}

    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 400, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 300, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents
private void construirInterfaz() {

    setTitle("Catálogo de Carreras UASD");
    setSize(900, 600);
    setLocationRelativeTo(null);

    getContentPane().removeAll();
    getContentPane().setLayout(new java.awt.BorderLayout(10, 10));

    javax.swing.JPanel panelSuperior = new javax.swing.JPanel(
        new java.awt.GridLayout(2, 2, 10, 10)
    );

    cmbFacultad = new javax.swing.JComboBox<>();
    cmbEscuela = new javax.swing.JComboBox<>();

    panelSuperior.add(new javax.swing.JLabel("Facultad:"));
    panelSuperior.add(cmbFacultad);
    panelSuperior.add(new javax.swing.JLabel("Escuela:"));
    panelSuperior.add(cmbEscuela);

    modelo = new javax.swing.table.DefaultTableModel(
        new String[]{"Facultad", "Escuela", "Carrera", "Nivel"}, 0
    );

    tblCarreras = new javax.swing.JTable(modelo);

    javax.swing.JButton btnBuscar =
        new javax.swing.JButton("Buscar carreras");

    javax.swing.JButton btnLimpiar =
        new javax.swing.JButton("Limpiar");

    javax.swing.JPanel panelBotones =
        new javax.swing.JPanel(new java.awt.FlowLayout());

    panelBotones.add(btnBuscar);
    panelBotones.add(btnLimpiar);

    getContentPane().add(panelSuperior, java.awt.BorderLayout.NORTH);
    getContentPane().add(
        new javax.swing.JScrollPane(tblCarreras),
        java.awt.BorderLayout.CENTER
    );
    getContentPane().add(panelBotones, java.awt.BorderLayout.SOUTH);

    cargarFacultades();

    cmbFacultad.addActionListener(e -> cargarEscuelas());

    if (cmbFacultad.getItemCount() > 0) {
        cargarEscuelas();
    }

    btnBuscar.addActionListener(e -> buscarCarreras());

    btnLimpiar.addActionListener(e -> modelo.setRowCount(0));

    revalidate();
    repaint();
}

private void cargarFacultades() {

    try (java.sql.Connection con = Conexion.conectar()) {

        String sql = "SELECT facultad_id, nombre "
                   + "FROM facultad ORDER BY nombre";

        java.sql.PreparedStatement ps = con.prepareStatement(sql);
        java.sql.ResultSet rs = ps.executeQuery();

        cmbFacultad.removeAllItems();

        while (rs.next()) {
            cmbFacultad.addItem(
                rs.getInt("facultad_id") + " - "
                + rs.getString("nombre")
            );
        }

        rs.close();
        ps.close();

    } catch (Exception e) {
        javax.swing.JOptionPane.showMessageDialog(this, e.getMessage());
    }
}

private void cargarEscuelas() {

    cmbEscuela.removeAllItems();

    if (cmbFacultad.getSelectedItem() == null) {
        return;
    }

    try (java.sql.Connection con = Conexion.conectar()) {

        String seleccion = cmbFacultad.getSelectedItem().toString();
        int facultadId = Integer.parseInt(seleccion.split(" - ")[0]);

        String sql = "SELECT escuela_id, nombre FROM escuela "
                   + "WHERE facultad_id = ? ORDER BY nombre";

        java.sql.PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, facultadId);

        java.sql.ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            cmbEscuela.addItem(
                rs.getInt("escuela_id") + " - "
                + rs.getString("nombre")
            );
        }

        rs.close();
        ps.close();

    } catch (Exception e) {
        javax.swing.JOptionPane.showMessageDialog(this, e.getMessage());
    }
}

private void buscarCarreras() {

    modelo.setRowCount(0);

    if (cmbEscuela.getSelectedItem() == null) {
        javax.swing.JOptionPane.showMessageDialog(
            this, "Selecciona una escuela."
        );
        return;
    }

    try (java.sql.Connection con = Conexion.conectar()) {

        String seleccion = cmbEscuela.getSelectedItem().toString();
        int escuelaId = Integer.parseInt(seleccion.split(" - ")[0]);

        String sql = "SELECT f.nombre AS facultad, "
                   + "e.nombre AS escuela, "
                   + "c.nombre AS carrera, c.nivel "
                   + "FROM facultad f "
                   + "JOIN escuela e ON f.facultad_id = e.facultad_id "
                   + "JOIN carrera c ON e.escuela_id = c.escuela_id "
                   + "WHERE e.escuela_id = ? "
                   + "ORDER BY c.nombre";

        java.sql.PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, escuelaId);

        java.sql.ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            modelo.addRow(new Object[]{
                rs.getString("facultad"),
                rs.getString("escuela"),
                rs.getString("carrera"),
                rs.getString("nivel")
            });
        }

        rs.close();
        ps.close();

    } catch (Exception e) {
        javax.swing.JOptionPane.showMessageDialog(this, e.getMessage());
    }
}
    
    public static void main(String args[]) {
        
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ReflectiveOperationException | javax.swing.UnsupportedLookAndFeelException ex) {
            logger.log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        
        java.awt.EventQueue.invokeLater(() -> new VentanaCatalogo().setVisible(true));
    }

    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    // End of variables declaration//GEN-END:variables
}
