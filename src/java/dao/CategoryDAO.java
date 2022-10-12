package dao;

import dto.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import utils.DBUtil;

public class CategoryDAO {

    public static boolean addCategory(String name) {
        boolean result = false;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "INSERT Categories VALUES(?)";
                PreparedStatement ps = conn.prepareCall(sql);
                ps.setString(1, name);
                result = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static ArrayList<Category> getCategories(String name) {
        ArrayList<Category> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT CateID, CateName FROM Categories WHERE CateName LIKE ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + name + "%");
                ResultSet result = ps.executeQuery();
                while (result.next()) {
                    int cateId = result.getInt("CateID");
                    String cateName = result.getString("CateName");
                    list.add(new Category(cateId, cateName));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public static boolean setName(int cateId, String name) {
        boolean res = false;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Categories SET CateName=? WHERE CateID=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setInt(2, cateId);
                res = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return res;
    }
}
