package dao;

import dto.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import utils.DBUtil;

public class AccountDAO {

    public static final int GET_ACCOUNT_BY_EMAIL = 0;
    public static final int GET_ACCOUNT_BY_TOKEN = 1;

    public static Account getAccount(String email, String password) {
        Account acc = null;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts "
                        + "WHERE status = 1 AND email = ? AND password = ? "
                        + "COLLATE Latin1_General_CS_AS";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet res = ps.executeQuery();
                if (res != null && res.next()) {
                    int accID = res.getInt("accID");
                    String fullname = res.getString("fullname");
                    String phone = res.getString("phone");
                    int status = res.getInt("status");
                    int role = res.getInt("role");
                    acc = new Account(accID, email, password, fullname, phone, status, role);
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
        return acc;
    }

    public static Account getAccount(String string, int option) {
        Account acc = null;
        Connection conn = null;
        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = (option == 1)
                        ? "SELECT accID, email, password, fullname, phone, status, role FROM Accounts "
                        + "WHERE status = 1 AND token = ?"
                        : "SELECT accID, email, password, fullname, phone, status, role FROM Accounts "
                        + "WHERE status = 1 AND email = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, string);
                ResultSet res = ps.executeQuery();
                if (res != null && res.next()) {
                    int accID = res.getInt("accID");
                    String email = res.getString("email");
                    String password = res.getString("password");
                    String fullname = res.getString("fullname");
                    String phone = res.getString("phone");
                    int status = res.getInt("status");
                    int role = res.getInt("role");
                    acc = new Account(accID, email, password, fullname, phone, status, role);
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
        return acc;
    }

    public static ArrayList<Account> getAccounts() {
        ArrayList<Account> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts";
                Statement st = conn.createStatement();
                ResultSet res = st.executeQuery(sql);
                if (res != null) {
                    while (res.next()) {
                        int accID = res.getInt("accID");
                        String email = res.getString("email");
                        String password = res.getString("password");
                        String fullname = res.getString("fullname");
                        String phone = res.getString("phone");
                        int status = res.getInt("status");
                        int role = res.getInt("role");
                        list.add(new Account(accID, email, password, fullname, phone, status, role));
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

    public static ArrayList<Account> getAccountsByName(String name) {
        ArrayList<Account> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "SELECT accID, email, password, fullname, phone, status, role FROM Accounts\n"
                        + "WHERE fullname LIKE ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, "%" + name + "%");
                ResultSet res = st.executeQuery();
                while (res.next()) {
                    int accID = res.getInt("accID");
                    String email = res.getString("email");
                    String password = res.getString("password");
                    String fullname = res.getString("fullname");
                    String phone = res.getString("phone");
                    int status = res.getInt("status");
                    int role = res.getInt("role");
                    list.add(new Account(accID, email, password, fullname, phone, status, role));
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

    public static boolean updateAccountStatus(String email, int status) {
        boolean res = false;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Accounts SET status = ? WHERE email = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setInt(1, status);
                st.setString(2, email);
                int rows = st.executeUpdate();
                if (rows > 0) {
                    res = true;
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

        return res;
    }

    public static boolean updateAccountToken(String email, String token) {
        boolean res = false;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Accounts SET token = ? WHERE email = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, token);
                st.setString(2, email);
                int rows = st.executeUpdate();
                if (rows > 0) {
                    res = true;
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

        return res;
    }

    public static boolean updateAccount(String email, String newPassword, String newFullname, String newPhone) {
        boolean res = false;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Accounts "
                        + "SET password = ?, fullname = ?, phone = ? "
                        + "WHERE email = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, newPassword);
                st.setString(2, newFullname);
                st.setString(3, newPhone);
                st.setString(4, email);
                int rows = st.executeUpdate();
                if (rows > 0) {
                    res = true;
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

        return res;
    }

    public static boolean insertAccount(String newEmail, String newPassword, String newFullname, String newPhone, int newStatus, int newRole) {
        boolean res = false;
        Connection conn = null;

        try {
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Accounts(email, password, fullname, phone, status, role) "
                        + "VALUES(?,?,?,?,?,?) ";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, newEmail);
                st.setString(2, newPassword);
                st.setString(3, newFullname);
                st.setString(4, newPhone);
                st.setInt(5, newStatus);
                st.setInt(6, newRole);
                int rows = st.executeUpdate();
                if (rows > 0) {
                    res = true;
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

        return res;
    }

    public static boolean removeToken(String email) {
        boolean res = false;
        Connection conn = null;

        try {
            if (email == null) {
                throw new NullPointerException();
            }
            conn = DBUtil.makeConnection();
            if (conn != null) {
                String sql = "UPDATE Accounts SET token = NULL WHERE email = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, email);
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
}
