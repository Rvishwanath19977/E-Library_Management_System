/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminServlets;

import Request.RequestDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author vishwanath
 */
@WebServlet(name = "AdminRequestServlet", urlPatterns = {"/AdminRequestServlet"})
public class AdminRequestServlet extends HttpServlet {

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
                //RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cpanel/orders.jsp");
                //dispatcher.forward(req, res);
                res.sendRedirect(req.getContextPath()+"/Admin/dashboard.jsp");
            }
            
            else {
                
                String action = req.getParameter("action").trim();
                
                if(action.equals("DECLINE")) {
                    
                    int id = Integer.parseInt(req.getParameter("request_id"));
                    
                    RequestDao requestDao = new RequestDao();
                    
                    if(requestDao.declineRequest(id) > 0) {
                        res.getWriter().write("Declined");
                    }
                    else {
                        res.getWriter().write("Failed");
                    }
                }
                
                if(action.equals("ACCEPT")) {
                    
                    int id = Integer.parseInt(req.getParameter("request_id"));
                    
                    RequestDao requestDao = new RequestDao();
                    
                    if(requestDao.acceptRequest(id) > 0) {
                        res.getWriter().write("Accepted");
                    }
                    else {
                        res.getWriter().write("Failed");
                    }
                }
                
                if(action.equals("DISBURSE")) {
                    int id = Integer.parseInt(req.getParameter("request_id"));
                    String  date = req.getParameter("date");
                    
                    RequestDao requestDao = new RequestDao();
                    
                    if(requestDao.disburseRequest(id,date) > 0) {
                        res.getWriter().write("Disbursed");
                    }
                    else {
                        res.getWriter().write("Failed");
                    }
                }
                
                if(action.equals("RETURN")) {
                    int id = Integer.parseInt(req.getParameter("request_id"));
                    String  date = req.getParameter("date");
                    
                    RequestDao requestDao = new RequestDao();
                    
                    if(requestDao.returnRequest(id,date) > 0) {
                        res.getWriter().write("Returned");
                    }
                    else {
                        res.getWriter().write("Failed");
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
