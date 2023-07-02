/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminServlets;

import Book.BookDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

/**
 *
 * @author vishwanath
 */
@WebServlet(name = "AdminBookServlet", urlPatterns = {"/AdminBookServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class AdminBookServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */

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
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        //processRequest(req, res);
            HttpSession session = req.getSession(true);
            if (session == null) {
                res.sendRedirect("http://localhost:8080/error.html");
            }
                        
            if(req.getParameter("action") == null) {
                //res.sendRedirect(req.getContextPath()+"/cpanel/products.jsp");
                //res.sendRedirect(req.getContextPath()+"/Admin/add-book.jsp");
            }
            
            else {
                
                String action = req.getParameter("action").trim();
                
                if(action.equals("CREATE")) {
                    String title = req.getParameter("title");
                    String price = req.getParameter("price");
                    String quantity = req.getParameter("quantity");
                    String category = req.getParameter("category");
                    String tags = req.getParameter("tags");
                    String author = req.getParameter("author");
                    String isbn = req.getParameter("isbn");
                    String description = req.getParameter("description");
                    String published_date = req.getParameter("published_date");
                    InputStream inputStream = null;
                    
                    Part filePart = req.getPart("fname");
                    
                    if(title.isEmpty() || price.isEmpty() || quantity.isEmpty() || category.isEmpty() || tags.isEmpty() || author.isEmpty() || isbn.isEmpty() || description.isEmpty() || published_date.isEmpty() || filePart == null) {
                        session.setAttribute("addProductError", "All input fields are required");
                        res.sendRedirect(req.getContextPath()+"/cpanel/add-product.jsp");
                    }
                    else {
                        System.out.println("Image type: "+ filePart.getContentType());
                        System.out.println("Image Size: "+ filePart.getSize());
                                                
                        if(filePart.getContentType().equals("image/png") || filePart.getContentType().equals("image/jpeg") || filePart.getContentType().equals("image/jpg")) {
                            
                             inputStream = filePart.getInputStream();

                             int newQuantity = Integer.parseInt(quantity);
                             int categoryId = Integer.parseInt(category);

                             BookDao bookDao = new BookDao();
                             if(bookDao.createBook(title, author, isbn, description, price, inputStream, published_date, newQuantity, categoryId, tags) > 0) {
                               session.setAttribute("addBookSuccess", "Book has been added successfully");
                             }
                             else {
                                 session.setAttribute("addBookError", "An error occurred while adding Book");
                             }
                             res.sendRedirect(req.getContextPath()+"/admin/add-book.jsp");
                        }
                        else {
                            session.setAttribute("addBookError", "Image type not supported");
                            res.sendRedirect(req.getContextPath()+"/admin/add-book.jsp");
                        }
                    }
                }
                
                if(action.equals("UPDATE")) {
                    int id = Integer.parseInt(req.getParameter("book_id"));
                    String price = req.getParameter("price");
                    String quantity = req.getParameter("quantity");
                    String tags = req.getParameter("tags");
                    
                    if(price.isEmpty() || quantity.isEmpty() || tags.isEmpty()) {
                        res.sendRedirect(req.getContextPath()+"/admin/view-books.jsp");
                    }
                    int quantityInInteger = Integer.parseInt(quantity);
                    BookDao bookDao = new BookDao();
                    
                    bookDao.updateBookDetails(quantityInInteger, price, id, tags);
                    res.sendRedirect(req.getContextPath()+"/admin/view-books.jsp");
                }
                
                if(action.equals("DELETE")) {
                    int id = Integer.parseInt(req.getParameter("book_id"));
                    
                    BookDao bookDao = new BookDao();
                    
                    if(bookDao.deleteBook(id) > 0) {
                        res.getWriter().write("Deleted");
                    }
                    else {
                        res.getWriter().write("Failed");
                    }
                    //res.sendRedirect(req.getContextPath()+"/cpanel/products.jsp");*/
                }
            }
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
