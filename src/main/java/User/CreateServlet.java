/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import utils.PasswordEncoder;
import User.UserDao;

/**
 *
 * @author vishwanath
 */
@WebServlet(name = "CreateServlet", urlPatterns = {"/CreateServlet"})
public class CreateServlet extends HttpServlet {

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
                res.sendRedirect(req.getContextPath()+"/register.jsp");
            }
            
            else {

                String action = req.getParameter("action").trim();

                if(action.equals("CREATE"))
                {
                    String name = req.getParameter("name");
                    String email = req.getParameter("email");
                    String phone = req.getParameter("phone");
                    String address = req.getParameter("address");
                    String password = req.getParameter("password");
                    String country = req.getParameter("country");

                    if(name.isEmpty() || email.isEmpty() || phone.isEmpty() || address.isEmpty() || password.isEmpty() || country.isEmpty()) {

                        session.setAttribute("createError", "All input fields are required");
                        res.sendRedirect(req.getContextPath()+"/register.jsp");
                    }
                    else {
                        
                        UserDao userDao = new UserDao();
                        if(userDao.UserExists(email)) {
                            session.setAttribute("createError", "User already exist kindly use another email");
                            res.sendRedirect(req.getContextPath()+"/register.jsp");
                        }
                        else if(password.length() < 6) {

                            session.setAttribute("createError", "Password cannot be less than 6 character length");
                            res.sendRedirect(req.getContextPath()+"/register.jsp");
                        }
                        else {
                            
                            PasswordEncoder passwordEncoder = new PasswordEncoder();

                            String encodedPassword = passwordEncoder.hashPassword(password);
                            int create = userDao.insert(name, email, address, phone, encodedPassword, country);
                            if(create > 0) {
                                session.setAttribute("createSuccess", "User has been created successfully kindly login");
                                res.sendRedirect(req.getContextPath()+"/login.jsp");
                            }
                            else {
                                session.setAttribute("createError", "Cannot create user, please try again later");
                                res.sendRedirect(req.getContextPath()+"/register.jsp");
                            }

                        }
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
