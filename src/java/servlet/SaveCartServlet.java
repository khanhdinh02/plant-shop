package servlet;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SaveCartServlet extends HttpServlet {

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
            // Check login
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");

            // Not logined
            if (email == null || email.isEmpty()) {
                request.setAttribute("warning", "You must login to finish the shopping!");
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
                return;
            }

            // Logined
            HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");

            // Empty cart
            if (cart == null || cart.isEmpty()) {
                request.setAttribute("warning", "Your cart is empty");
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
                return;
            }
            // Not empty cart
            boolean res = OrderDAO.insertOrder(email, cart);
            if (!res) {
                request.setAttribute("warning", "Some products are out of stock");
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
            } else {
                session.removeAttribute("cart");
                request.setAttribute("warning", "Save your cart successfully");
                request.getRequestDispatcher("viewCart.jsp").forward(request, response);
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
