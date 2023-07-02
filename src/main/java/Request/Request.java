/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Request;

import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Base64;

/**
 *
 * @author vishwanath
 */
public class Request {
    
    private int id;
    private String name;
    private String book;
    private String amount;
    private boolean disbursed;
    private String disbursedDate;
    private Blob thumbnail;
    private String decision;
    private boolean returned;
    private String returnedDate;
    private Date dateCreated;
    private Date dateUpdated;
    private boolean status;
    private String dateToBeReturned;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBook() {
        return book;
    }

    public void setBook(String book) {
        this.book = book;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public boolean isDisbursed() {
        return disbursed;
    }

    public void setDisbursed(boolean disbursed) {
        this.disbursed = disbursed;
    }

    public String getDisbursedDate() {
        return disbursedDate;
    }

    public void setDisbursedDate(String disbursedDate) {
        this.disbursedDate = disbursedDate;
    }

    public String getDecision() {
        return decision;
    }

    public void setDecision(String decision) {
        this.decision = decision;
    }

    public boolean isReturned() {
        return returned;
    }

    public void setReturned(boolean returned) {
        this.returned = returned;
    }

    public String getReturnedDate() {
        return returnedDate;
    }

    public void setReturnedDate(String returnedDate) {
        this.returnedDate = returnedDate;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(Date dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getDateToBeReturned() {
        return dateToBeReturned;
    }

    public void setDateToBeReturned(String dateToBeReturned) {
        this.dateToBeReturned = dateToBeReturned;
    }
    
    public Blob getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(Blob thumbnail) {
        this.thumbnail = thumbnail;
    }
    
    public String getEncodedPhoto() throws SQLException {
        return Base64.getEncoder().encodeToString(this.getThumbnail().getBytes(1,(int)thumbnail.length()));
    }
    
}
