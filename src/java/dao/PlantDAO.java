package dao;

import dto.Plant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DBUtil;

public class PlantDAO {

    public static boolean addPlant(String name, int price, String description, int cateId) {
        boolean result = false;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "INSERT Plants(PName, price, description, CateID, status) VALUES (?,?,?,?,1)";
                PreparedStatement ps = conn.prepareCall(sql);
                ps.setString(1, name);
                ps.setInt(2, price);
                ps.setString(3, description);
                ps.setInt(4, cateId);
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

    public static ArrayList<Plant> getPlants(String keyword, String searchBy) {
        ArrayList<Plant> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                StringBuilder sql = new StringBuilder("SELECT PID, PName, price, imgPath, description, status, Plants.CateID 'CateID', CateName "
                        + "FROM Plants INNER JOIN Categories ON Plants.CateID = Categories.CateID ");
                if (searchBy.equalsIgnoreCase("byname")) {
                    sql.append("WHERE PName LIKE ?");
                } else {
                    sql.append("WHERE CateName LIKE ?");
                }
                PreparedStatement st = conn.prepareStatement(sql.toString());
                st.setString(1, "%" + keyword + "%");
                ResultSet res = st.executeQuery();
                if (res != null) {
                    while (res.next()) {
                        int id = res.getInt("PID");
                        String name = res.getString("PName");
                        int price = res.getInt("price");
                        String imgPath = res.getString("imgPath");
                        String description = res.getString("description");
                        int status = res.getInt("status");
                        int cateId = res.getInt("CateID");
                        String cateName = res.getString("CateName");
                        list.add(new Plant(id, name, price, imgPath, description, status, cateId, cateName));
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }

        return list;
    }

    public static Plant getPlant(int id) {
        Plant p = null;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT PID,PName,price,imgPath,description,status,Plants.CateID AS 'cateid',CateName\n"
                        + "FROM Categories, Plants\n"
                        + "WHERE Categories.CateID = Plants.CateID AND PID=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                ResultSet table = ps.executeQuery();
                if (table != null && table.next()) {
                    int pid = table.getInt("PID");
                    String pname = table.getString("PName");
                    int price = table.getInt("price");
                    String imgpath = table.getString("imgPath");
                    String description = table.getString("description");
                    int status = table.getInt("status");
                    int cateid = table.getInt("cateid");
                    String catename = table.getString("CateName");
                    p = new Plant(pid, pname, price, imgpath, description, status, cateid, catename);
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

        return p;
    }

    public static boolean setStatus(int id, int status) {
        boolean res = false;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Plants SET status = ? WHERE PID = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setInt(1, status);
                st.setInt(2, id);
                res = st.executeUpdate() > 0;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }

        return res;
    }

    public static boolean setImgPath(int id, String imgName) {
        boolean result = false;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Plants SET imgPath=? WHERE PID=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, "images/" + imgName);
                ps.setInt(2, id);
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

    public static boolean updatePlant(int id, String name, int price, String description, int cateId) {
        boolean result = false;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Plants SET PName=?, price=?, description=?, CateID=?\n"
                        + "WHERE PID=?";
                PreparedStatement ps = conn.prepareCall(sql);
                ps.setString(1, name);
                ps.setInt(2, price);
                ps.setString(3, description);
                ps.setInt(4, cateId);
                ps.setInt(5, id);
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
}
