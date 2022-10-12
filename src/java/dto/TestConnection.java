package dto;

import dao.AccountDAO;
import java.util.List;

public class TestConnection {

    public static void main(String[] args) {

//        Account acc = AccountDAO.getAccount("b@b", "b");
//        if (acc != null)
//            if (acc.getRole() == 1)
//                System.out.println("I am an admin");
//            else
//                System.out.println("I am an user");
//        else
//            System.out.println("Login fail");

        // Challenge 1
//        List<Account> list = AccountDAO.getAccounts();
//        list.forEach(account -> {
//            System.out.println(account.getAccID() + ", " + account.getEmail());
//        });
        
        // Challenge 2
//        System.out.println(AccountDAO.updateAccountStatus("c@c", 0));
        
        // challenge 3
//        System.out.println(AccountDAO.updateAccount("c@c", "ccc", "ccc", null));
        
        // Challenge 4
        System.out.println(AccountDAO.insertAccount("d@d", null, null, null, 1, 1));
    }
}
