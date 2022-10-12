package dto;

import java.io.Serializable;

public class Category implements Serializable {
    private int cateId;
    private String cateName;

    public Category() {
    }

    public Category(int cateId, String cateName) {
        this.cateId = cateId;
        this.cateName = cateName;
    }

    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
}
