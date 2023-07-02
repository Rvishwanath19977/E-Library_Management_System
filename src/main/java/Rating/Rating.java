/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Rating;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

/**
 *
 * @author vishwanath
 */
public class Rating {
    private int id;
    private int categoryId;
    private Blob thumbnail;
    private String title;
    private double score;
    private int count;
    private String author;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Blob getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(Blob thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
    
    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    
    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getEncodedPhoto() throws SQLException {
        return Base64.getEncoder().encodeToString(this.getThumbnail().getBytes(1,(int)thumbnail.length()));
    }
    
}
