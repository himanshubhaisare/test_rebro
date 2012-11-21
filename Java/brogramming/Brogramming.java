/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package brogramming;

import java.util.ArrayList;

/**
 *
 * @author hbhaisare
 */
public class Brogramming {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String in = null;
        ArrayList out = doIt(in);
        /**
         * For testing
        System.out.println(out.toString());
        */
    }
    
    /**
     * Removes adjacent repeating characters 
     * @param String in
     * @return Arraylist out
     */
    public static ArrayList doIt(String in) {
        ArrayList out = new ArrayList();
        char[] str = in.toCharArray();
        for(int i =0; i<str.length; i++) {
           //print only if number in front is different
            if(i+1 != str.length) {
                if(str[i] != str[i+1]) {
                    out.add(str[i]);
                }
            } else {
                out.add(str[i]);
            }
        }
        return out;
    }
}