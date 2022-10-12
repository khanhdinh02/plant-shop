package servlet;

import dao.PlantDAO;
import dto.Plant;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchServlet extends HttpServlet {

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
            String keyword = request.getParameter("txtsearch");
            String searchBy = request.getParameter("searchby");
            ArrayList<Plant> list = PlantDAO.getPlants(keyword, searchBy);

            if (list != null) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet SearchServlet</title>");
                out.println("<link rel='stylesheet' href='mycss.css' type='text/css' />");
                out.println("</head>");
                out.println("<body><section>");

                ServletContext context = getServletContext();
                String tmp = context.getInitParameter("countryName");
                out.println("<p>The website is deploying in " + tmp + "</p>");

                ServletConfig config = getServletConfig();
                String lang = config.getInitParameter("language");
                out.println("<p>Language: " + lang + "</p>");

                out.println("<table class='producttable order'>");
                out.println("<tr><td>product id</td><td>name</td><td>price</td>");
                out.println("<td>image</td><td>detail</td><td>action</td></tr>");
                list.forEach(plant -> {
                    out.println("<tr>");
                    out.println("<td>" + plant.getId() + "</td>");
                    out.println("<td>" + plant.getName() + "</td>");
                    out.println("<td>" + plant.getPrice() + "</td>");
                    out.println("<td><img src='" + plant.getImgPath() + "' class='product'/></td>");
                    out.println("<td><a href='#'>view detail</a></td>");
                    out.println("<td><a href='#'>add to cart</a></td>");
                    out.println("</tr>");
                });
                out.println("</table></section></body>");
                out.println("</html>");
            }
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
