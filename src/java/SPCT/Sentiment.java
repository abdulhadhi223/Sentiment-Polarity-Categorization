/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SPCT;

import DBconnection.SQLconnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

/**
 *
 * @author nadanapathy
 */
public class Sentiment {

    public String removeAP(String comment) throws Exception {

        Statement st = SQLconnection.getconnection().createStatement();
        ResultSet rt;
        StringBuffer sb = new StringBuffer();
        String[] sens = comment.split("\\.");

        for (String sen : sens) {
            String[] words = sen.split(" ");
            for (String word : words) {
                rt = st.executeQuery("SELECT iddictionary FROM dictionary where words='" + word + "' and (sentiment='2' or sentiment='3');");
                if (!rt.next()) {
                    sb.append(word + " ");
                }
            }
            sb.append(".");
        }

        return sb.toString();
    }

    public int getSentiment(String word) throws Exception {
        Connection con = SQLconnection.getconnection();
        Statement st = con.createStatement();
        ResultSet rt = st.executeQuery("select sentiment from dictionary where words='" + word + "'");
        int snmt = 0;
        if (rt.next()) {
            try {
                snmt = Integer.parseInt(rt.getString("sentiment"));
            } catch (NullPointerException ne) {

            }
        }
        return snmt;
    }

    public int compareWords(int word, int position, String[] words) throws Exception {
        //System.out.println("compare words position :"+position);
        int fsnmt = 0;
        int snmt1 = 0;
        int snmt2 = 0;
        Connection con = SQLconnection.getconnection();
        Statement st = con.createStatement();

        ResultSet rt = null;
        if (position > 1) {
            rt = st.executeQuery("SELECT sentiment,(select sentiment from dictionary where words='" + words[position - 2] + "') FROM dictionary where words='" + words[position - 1] + "' ;");
            if (rt.next()) {

                try {
                    snmt1 = Integer.parseInt(rt.getString("sentiment"));
                } catch (NumberFormatException nfe) {
                    snmt1 = 0;
                }
                System.out.print(" snmt1:" + snmt1 + " \n");
                try {
                    snmt2 = Integer.parseInt(rt.getString("(select sentiment from dictionary where words='" + words[position - 2] + "')"));

                } catch (NumberFormatException nfe) {
                    snmt2 = 0;
                }
                System.out.print(" snmt2:" + snmt2 + " ");
//                            System.out.println("Before first sentiment:"+snmt1);
//                            System.out.println("Before second sentiment:"+snmt2);

                if (snmt1 == 7) {
                    switch (snmt2) {
                        case 6:
                            if (word == 1 || word == -1) {
                                fsnmt = 0;
                            }
                            ;
                            break;
                        case 1:
                            fsnmt = word;
                            break;
                        case -1:
                            fsnmt = word;
                            break;
                        default:
                            fsnmt = word;
                    }
                } else {
                    switch (snmt1) {
                        case 6:
                            if (word == 1) {
                                fsnmt = -1;
                            } else {
                                if (word == -1) {
                                    fsnmt = 1;
                                } else {
                                    fsnmt = 0;
                                }
                            }
                            ;
                            break;
                        case 0:
                            fsnmt = word;
                            break;

                        default:
                            fsnmt = word;

                    }
                }

            } else {
                fsnmt = word;
            }
        } else {
            rt = st.executeQuery("SELECT sentiment FROM dictionary where words='" + words[position - 1] + "' ;");
            if (rt.next()) {
                try {
                    snmt1 = Integer.parseInt(rt.getString("sentiment"));
                } catch (NumberFormatException nfe) {
                    snmt1 = 0;
                }
                switch (snmt1) {
                    case 6:
                        if (word == 1) {
                            fsnmt = -1;
                        } else {
                            if (word == -1) {
                                fsnmt = 1;
                            } else {
                                fsnmt = 0;
                            }
                        }
                        ;
                        break;
                    case 0:
                        fsnmt = word;
                        break;

                    default:
                        fsnmt = word;

                }
            } else {
                fsnmt = word;
            }
        }

        return fsnmt;
    }

    public float findSentiment(String comment) throws Exception {
        int poscount = 0, negcount = 0, undefined = 0, neutralcount = 0;

//        Connection con= Dbconnection.getConn();
//        Statement st=con.createStatement();
        ResultSet rt;
        System.out.println("Before Removed :" + comment);
        String cmt = removeAP(comment);
        System.out.println("After Removed :" + cmt);

        String[] sens = cmt.split("\\.");
        for (String sen : sens) {
            String[] words = sen.split(" ");
            int wordcount = 0;
            for (String word : words) {
                System.out.println("---------------------------------------" + wordcount);
                System.out.println("Processing Word :" + word + " ");
                int snmt = getSentiment(word);
                System.out.println("" + word + " -- Word sentiment: " + snmt);
                if (wordcount > 0) {
                    int snmt1 = compareWords(snmt, wordcount, words);
                    switch (snmt1) {
                        case 0:
                            neutralcount++;
                            System.out.println("neutral word :" + word);
                            break;
                        case 1:
                            poscount++;
                            System.out.println("positive word :" + word);
                            break;
                        case -1:
                            negcount++;
                            System.out.println("negative word :" + word);
                            break;
                        default:
                            undefined++;
                    }
                }
                System.out.println("Completed...");
//                 System.out.println("---------------------------------------");
                wordcount++;
            }

        }

        System.out.println("--------------process completed-------------------------");
        System.out.println("Positive count :" + poscount);
        System.out.println("Negative count :" + negcount);
        System.out.println("Neutral count :" + neutralcount);
        System.out.println("Undefined count :" + undefined);
        HashMap counts = new HashMap();

        counts.put("positive", poscount);
        counts.put("negative", negcount);
        counts.put("neutral", neutralcount);
        counts.put("undefined", undefined);

        float fi = poscount - negcount;

        System.out.println(" Review  :" + fi);

        return fi;
    }

    public float findAspectSentiment(String comment, String aspect) throws Exception {
        int poscount = 0, negcount = 0, undefined = 0, neutralcount = 0;

//        Connection con= Dbconnection.getConn();
//        Statement st=con.createStatement();
        ResultSet rt;
        System.out.println("Before Removed :" + comment);
        String cmt = removeAP(comment);
        System.out.println("After Removed :" + cmt);

        String[] sens = cmt.split("\\.");
        for (String sen : sens) {
            String[] words = sen.split(" ");
            if (sen.contains(aspect)) {
                int wordcount = 0;
                for (String word : words) {

                    System.out.println("---------------------------------------" + wordcount);
                    System.out.println("Processing Word :" + word + " ");
                    int snmt = getSentiment(word);
                    System.out.println("" + word + " -- Word sentiment: " + snmt);
                    if (wordcount > 0) {
                        int snmt1 = compareWords(snmt, wordcount, words);
                        switch (snmt1) {
                            case 0:
                                neutralcount++;
                                System.out.println("neutral word :" + word);
                                break;
                            case 1:
                                poscount++;
                                System.out.println("positive word :" + word);
                                break;
                            case -1:
                                negcount++;
                                System.out.println("negative word :" + word);
                                break;
                            default:
                                undefined++;
                        }
                    }
                    System.out.println("Completed...");
//                 System.out.println("---------------------------------------");
                    wordcount++;
                }
            }

        }

        System.out.println("--------------process completed-------------------------");
        System.out.println("Positive count :" + poscount);
        System.out.println("Negative count :" + negcount);
        System.out.println("Neutral count :" + neutralcount);
        System.out.println("Undefined count :" + undefined);
        HashMap counts = new HashMap();

        counts.put("positive", poscount);
        counts.put("negative", negcount);
        counts.put("neutral", neutralcount);
        counts.put("undefined", undefined);

        float fi = poscount - negcount;

        System.out.println(" Review  :" + fi);

        return fi;
    }

//    public static void main(String[] aaa)throws Exception{
//        Sentiment ss=new Sentiment();
//        String cmt="Mobile has issue with ear speaker. Very low volume";
//        ss.findAspectSentiment(cmt, "speaker");
//    }
}
