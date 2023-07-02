/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 *
 * @author vishwanath
 */
@WebServlet(name = "BookServlet", urlPatterns = {"/BookServlet"})
public class BookServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = res.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
                        HttpSession session = req.getSession(true);
            if (session == null) {
                res.sendRedirect("http://localhost:8080/error.html");
            }
            
            if(req.getParameter("action") == null) {
                res.sendRedirect(req.getContextPath()+"/index.jsp");
            }
            
            else {

                String action = req.getParameter("action").trim();

                if(action.equals("ORDER"))
                {
                    String pan = req.getParameter("pan");
                    String expiry = req.getParameter("expiry");
                    String cvv = req.getParameter("cvv");
                    String name = req.getParameter("name");
                    String price = req.getParameter("price_to_pay");
                    String returnDate = req.getParameter("return_date");
                    String bookIdParam = req.getParameter("book_id");
                    

                    if(pan.isEmpty() || expiry.isEmpty() || cvv.isEmpty() || name.isEmpty() || price.isEmpty() || returnDate.isEmpty() || bookIdParam.isEmpty()) {
                        session.setAttribute("paymentError", "All input fields are required");
                        res.sendRedirect(req.getContextPath()+"/request-book.jsp?book="+bookIdParam);
                    }
                    else {
                        
                        int bookId = Integer.parseInt(bookIdParam);
                        
                        BookDao bookDao = new BookDao();
                        if(bookDao.createRequest(price, 1, bookId, returnDate) > 0) {
                            session.setAttribute("paymentError", "Request created successfully");
                            res.sendRedirect(req.getContextPath()+"/request-book.jsp?book="+bookIdParam);
                        } 
                        /*int orderCreated = 0;
                        
                        boolean errorEncountered = false;
                        String msg = "";
                        if(validateCardDetails(pan, expiry, cvv, name)) {

                        }*/
                    }

                }

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
