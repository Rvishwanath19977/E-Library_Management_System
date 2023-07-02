/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminServlets;

import Category.CategoryDao;
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
@WebServlet(name = "AdminCategoryServlet", urlPatterns = {"/AdminCategoryServlet"})
public class AdminCategoryServlet extends HttpServlet {

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
                
                if(action.equals("DELETE")) {
                    int id = Integer.parseInt(req.getParameter("category_id"));
                    
                    CategoryDao categoryDao = new CategoryDao();
                    
                    if(categoryDao.deleteCategory(id) > 0) {
                        res.getWriter().write("Deleted");
                    }
                    else {
                        res.getWriter().write("Failed");
                    }
                    //categoryDao.deleteCategory(id);
                    //res.sendRedirect(req.getContextPath()+"/Admin/categories.jsp");
                }
                
                if(action.equals("CREATE")) {
                                        
                    String name = req.getParameter("name");
                    
                    if(name.isEmpty()) {
                        session.setAttribute("addCategoryError", "All input fields are required");
                        res.sendRedirect(req.getContextPath()+"/Admin/add-category.jsp");
                    }
                    else {
                        
                        CategoryDao categoryDao = new CategoryDao();
                        if(categoryDao.createCategory(name) > 0) { 
                          session.setAttribute("addCategorySuccess", "Category has been added successfully");
                        }
                        else {
                            session.setAttribute("addCategoryError", "An error occurred while adding product");
                        }
                        res.sendRedirect(req.getContextPath()+"/Admin/add-category.jsp");
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
