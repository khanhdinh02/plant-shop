package dao;

import dto.Account;
import dto.Order;
import dto.OrderDetail;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;
import utils.DBUtil;

public class OrderDAO {

    public static ArrayList<Order> getOrders() {
        Connection conn = null;
        ArrayList<Order> list = new ArrayList<>();

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT OrderID, OrdDate, shipdate, status, AccID\n"
                        + "FROM Orders";
                PreparedStatement st = conn.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderID = rs.getInt("OrderID");
                        String orderDate = rs.getString("OrdDate");
                        String shipDate = rs.getString("shipdate");
                        int status = rs.getInt("status");
                        int accID = rs.getInt("AccID");
                        list.add(new Order(orderID, orderDate, shipDate, status, accID));
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

    public static ArrayList<Order> getOrders(String email) {
        Connection conn = null;
        ArrayList<Order> list = new ArrayList<>();

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT OrderID, OrdDate, shipdate, Orders.status, Orders.AccID 'AccID' "
                        + "FROM Orders INNER JOIN Accounts ON Orders.AccID = Accounts.accID "
                        + "WHERE email = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, email);
                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderID = rs.getInt("OrderID");
                        String orderDate = rs.getString("OrdDate");
                        String shipDate = rs.getString("shipdate");
                        int status = rs.getInt("status");
                        int accID = rs.getInt("AccID");
                        list.add(new Order(orderID, orderDate, shipDate, status, accID));
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

    public static ArrayList<Order> getOrdersByAccId(int accId) {
        Connection conn = null;
        ArrayList<Order> list = new ArrayList<>();

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT OrderID, OrdDate, shipdate, status, AccID "
                        + "FROM Orders WHERE AccID = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setInt(1, accId);
                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderID = rs.getInt("OrderID");
                        String orderDate = rs.getString("OrdDate");
                        String shipDate = rs.getString("shipdate");
                        int status = rs.getInt("status");
                        int accID = rs.getInt("AccID");
                        list.add(new Order(orderID, orderDate, shipDate, status, accID));
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

    public static ArrayList<Order> getOrdersByDate(String email, Date startDate, Date endDate) {
        Connection conn = null;
        ArrayList<Order> list = new ArrayList<>();

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                StringBuilder sql = new StringBuilder("SELECT OrderID, OrdDate, shipdate, Orders.status, Orders.AccID 'AccID' "
                        + "FROM Orders INNER JOIN Accounts ON Orders.AccID = Accounts.accID "
                        + "WHERE email = ?");

                if (startDate != null) {
                    sql.append(" AND OrdDate>=?");
                }
                if (endDate != null) {
                    sql.append(" AND OrdDate<=?");
                }

                PreparedStatement st = conn.prepareStatement(sql.toString());
                st.setString(1, email);

                if (startDate != null) {
                    st.setDate(2, startDate);
                    if (endDate != null) {
                        st.setDate(3, endDate);
                    }
                } else if (endDate != null) {
                    st.setDate(2, endDate);
                }

                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderID = rs.getInt("OrderID");
                        String orderDate = rs.getString("OrdDate");
                        String shipDate = rs.getString("shipdate");
                        int status = rs.getInt("status");
                        int accID = rs.getInt("AccID");
                        list.add(new Order(orderID, orderDate, shipDate, status, accID));
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

    public static ArrayList<Order> getOrdersByDate(Date startDate, Date endDate) {
        Connection conn = null;
        ArrayList<Order> list = new ArrayList<>();

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                StringBuilder sql = new StringBuilder("SELECT OrderID, OrdDate, shipdate, status, AccID "
                        + "FROM Orders");

                if (startDate != null) {
                    sql.append(" WHERE OrdDate>=?");
                    if (endDate != null) {
                        sql.append(" AND OrdDate<=?");
                    }
                } else if (endDate != null) {
                    sql.append(" WHERE OrdDate<=?");
                }

                PreparedStatement st = conn.prepareStatement(sql.toString());
                if (startDate != null) {
                    st.setDate(1, startDate);
                    if (endDate != null) {
                        st.setDate(2, endDate);
                    }
                } else if (endDate != null) {
                    st.setDate(1, endDate);
                }

                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderID = rs.getInt("OrderID");
                        String orderDate = rs.getString("OrdDate");
                        String shipDate = rs.getString("shipdate");
                        int status = rs.getInt("status");
                        int accID = rs.getInt("AccID");
                        list.add(new Order(orderID, orderDate, shipDate, status, accID));
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

    public static ArrayList<OrderDetail> getOrderDetail(int orderID) {
        Connection conn = null;
        ArrayList<OrderDetail> list = new ArrayList<>();
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT DetailId, OrderID, PID, PName, price, imgPath, quantity"
                        + " FROM OrderDetails INNER JOIN Plants ON OrderDetails.FID = Plants.PID"
                        + " WHERE OrderID=?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setInt(1, orderID);
                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int orderDetailID = rs.getInt("DetailId");
                        int plantID = rs.getInt("PID");
                        String plantName = rs.getString("PName");
                        int price = rs.getInt("price");
                        String imgPath = rs.getString("imgPath");
                        int quantity = rs.getInt("quantity");
                        list.add(new OrderDetail(orderDetailID, orderID, plantID, plantName, price, imgPath, quantity));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    public static boolean setStatus(int orderID, int status) {
        boolean success = false;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                PreparedStatement st;
                switch (status) {
                    case Order.STATUS_PROCESSING:
                        st = conn.prepareStatement("UPDATE Orders SET status=?, OrdDate=? WHERE OrderID=?");
                        st.setInt(1, status);
                        st.setDate(2, new Date(System.currentTimeMillis()));
                        st.setInt(3, orderID);
                        break;
                    case Order.STATUS_CANCELED:
                        st = conn.prepareStatement("UPDATE Orders SET status=? WHERE OrderID=?");
                        st.setInt(1, status);
                        st.setInt(2, orderID);
                        break;
                    default:
                        throw new IllegalArgumentException("status must be either 1 or 3");
                }
                success = st.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return success;
    }

    public static boolean setProcessingOrCompleted(int orderID, int status) {
        boolean success = false;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                PreparedStatement st;
                switch (status) {
                    case Order.STATUS_PROCESSING:
                        st = conn.prepareStatement("UPDATE Orders SET status=?, shipdate=NULL WHERE OrderID=?");
                        st.setInt(1, status);
                        st.setInt(2, orderID);
                        break;
                    case Order.STATUS_COMPLETED:
                        st = conn.prepareStatement("UPDATE Orders SET status=?, shipdate=? WHERE OrderID=?");
                        st.setInt(1, status);
                        st.setDate(2, new Date(System.currentTimeMillis()));
                        st.setInt(3, orderID);
                        break;
                    default:
                        throw new IllegalArgumentException("status must be either 1 or 2");
                }
                success = st.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return success;
    }

    public static boolean insertOrder(String email, HashMap<String, Integer> cart) {
        boolean res = false;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                int accId = 0;
                int orderId = 0;
                String sql;
                PreparedStatement ps;
                conn.setAutoCommit(false);

                // Get account id by email
                Account acc = AccountDAO.getAccount(email, AccountDAO.GET_ACCOUNT_BY_EMAIL);
                if (acc != null) {
                    accId = acc.getAccID();
                }

                // Insert new order
                Date orderDate = new Date(System.currentTimeMillis());
                sql = "INSERT Orders(OrdDate, status, AccID) VALUES(?,?,?)";
                ps = conn.prepareStatement(sql);
                ps.setDate(1, orderDate);
                ps.setInt(2, 1);
                ps.setInt(3, accId);
                ps.executeUpdate();

                // Get inserted OrderId
                sql = "SELECT TOP 1 OrderID FROM Orders ORDER BY OrderID desc";
                ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    orderId = rs.getInt("OrderID");
                }

                // Insert order details
                Set<String> pids = cart.keySet();
                for (String pid : pids) {
                    // Check status
                    if (PlantDAO.getPlant(Integer.parseInt(pid)).getStatus() != 1) {
                        throw new RuntimeException();
                    }

                    sql = "INSERT OrderDetails VALUES(?,?,?)";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, orderId);
                    ps.setInt(2, Integer.parseInt(pid.trim()));
                    ps.setInt(3, cart.get(pid));
                    ps.executeUpdate();
                }

                conn.commit();
                res = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return res;
    }
}
