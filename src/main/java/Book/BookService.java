/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import utils.ConnectionPool;
import utils.DBUtil;

/**
 *
 * @author vishwanath
 */
public class BookService {
    
    private Pattern pattern = Pattern.compile("-?\\d+(\\.\\d+)?");
    
    public String getPagination(int categoryId, int page, double limit, int start, double total_record) {
        
        BookDao bookdao = new BookDao();
 

        String output = "";
        output += "<nav aria-label='...' style='margin-top:20px'>\n" +
        "<ul class='pagination justify-content-end'>";
        
        int previous = page - 1;
        int next = page + 1;
        int total_number_pages = (int)Math.ceil(total_record/limit);
        if(previous > 0) {
           //output += "<button>Previous</button>";
           output += "<li class='page-item'>\n" +
                    "<a class='page-link' href=\"index.jsp?category="+categoryId+"&page="+previous+"\" tabindex='-1'>Previous</a>\n" +
                "</li>";
        }
        if(total_number_pages > 1) {
            for(int i = 1; i <= total_number_pages; i++) {
                
                if(page == i) {
                    output += "<li class='page-item active'>\n" +
                "<a class='page-link' href='#'>"+i+" <span class='sr-only'>(current)</span></a>\n" +
                "</li>";
                }
                else {
                    output += "<li class='page-item'><a class='page-link' href=\"index.jsp?category="+categoryId+"&page="+i+"\">"+i+"</a></li>";
                }
                
            }
            if(next <= total_number_pages) {
                //output += "<button>Next</button>";
                output += "<li class='page-item'>\n" +
            "<a class='page-link' href=\"index.jsp?category="+categoryId+"&page="+next+"\">Next</a>\n" +
            "</li>";
            }
        }
        output += "</ul>\n" +
            "</nav>";
        return output;
    }

    public boolean isNumeric(String strNum) {
        if (strNum == null) {
            return false; 
        }
        return this.pattern.matcher(strNum).matches();
    }
}
