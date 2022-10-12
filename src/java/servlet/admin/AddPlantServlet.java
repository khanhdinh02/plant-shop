package servlet.admin;

import dao.PlantDAO;
import dto.Plant;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import utils.ImageUploader;

public class AddPlantServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            int price = Integer.parseInt(request.getParameter("price"));
            String description = request.getParameter("description");
            int cateId = Integer.parseInt(request.getParameter("cateId"));

            // Path to save image
            String path = request.getServletContext().getRealPath("images");
            // Get image from form
            Part imgPart = request.getPart("img");

            // Add Plant
            if (name != null && !name.isEmpty()) {
                PlantDAO.addPlant(name, price, description, cateId);
                
                // Get the added plantId
                List<Plant> list = PlantDAO.getPlants(name, "byname");
                Plant plant = list.get(list.size() - 1);
                int id = plant.getId();

                // Upload image to server and save path to db
                String imgName = ImageUploader.upload(id, imgPart, path);
                if (imgName != null) {
                    PlantDAO.setImgPath(id, imgName);
                }
            }

            response.sendRedirect("MainController?action=managePlants");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
