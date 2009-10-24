package com.neosavvy.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

public class SQLFormatter
{

    public SQLFormatter()
    {
        multiLine = false;
        doubleSpace = true;
        newline = System.getProperty("line.separator");
        lineLength = 72;
        wrapIndent = "        ";
        clauseIndent = "    ";
    }

    public void setNewline(String val)
    {
        newline = val;
    }

    public String getNewline()
    {
        return newline;
    }

    public void setLineLength(int val)
    {
        lineLength = val;
    }

    public int getLineLength()
    {
        return lineLength;
    }

    public void setWrapIndent(String val)
    {
        wrapIndent = val;
    }

    public String getWrapIndent()
    {
        return wrapIndent;
    }

    public void setClauseIndent(String val)
    {
        clauseIndent = val;
    }

    public String getClauseIndent()
    {
        return clauseIndent;
    }

    public void setMultiLine(boolean multiLine)
    {
        this.multiLine = multiLine;
    }

    public boolean getMultiLine()
    {
        return multiLine;
    }

    public void setDoubleSpace(boolean doubleSpace)
    {
        this.doubleSpace = doubleSpace;
    }

    public boolean getDoubleSpace()
    {
        return doubleSpace;
    }

    public Object prettyPrint(Object sqlObject)
    {
        if(!multiLine)
            return prettyPrintLine(sqlObject);
        StringBuffer sql = new StringBuffer(sqlObject.toString());
        StringBuffer buf = new StringBuffer(sql.length());
        while(sql.length() > 0) 
        {
            String line = null;
            int index = Math.max(sql.toString().indexOf(";\n"), sql.toString().indexOf(";\r"));
            if(index == -1)
                line = sql.toString();
            else
                line = sql.substring(0, index + 2);
            sql.delete(0, line.length());
            buf.append(prettyPrintLine(line));
            int i = 0;
            while(i < 1 + (getDoubleSpace() ? 1 : 0)) 
            {
                buf.append(System.getProperty("line.separator"));
                i++;
            }
        }
        return buf.toString();
    }

    private Object prettyPrintLine(Object sqlObject)
    {
        String sql = sqlObject.toString().trim();
        String lowerCaseSql = sql.toLowerCase();
        String separators[];
        if(lowerCaseSql.startsWith("select"))
            separators = selectSeparators;
        else
        if(lowerCaseSql.startsWith("insert"))
            separators = insertSeparators;
        else
        if(lowerCaseSql.startsWith("update"))
            separators = updateSeparators;
        else
        if(lowerCaseSql.startsWith("delete"))
            separators = deleteSeparators;
        else
        if(lowerCaseSql.startsWith("create table"))
            separators = createTableSeparators;
        else
        if(lowerCaseSql.startsWith("create index"))
            separators = createIndexSeparators;
        else
            separators = new String[0];
        int start = 0;
        int end = -1;
        List clauses = new ArrayList();
        clauses.add(new StringBuffer());
        int i = 0;
        StringBuffer clause;
        do
        {
            if(i >= separators.length)
                break;
            end = lowerCaseSql.indexOf(" " + separators[i].toLowerCase(), start);
            if(end == -1)
                break;
            clause = (StringBuffer)clauses.get(clauses.size() - 1);
            clause.append(sql.substring(start, end));
            clause = new StringBuffer();
            clauses.add(clause);
            clause.append(clauseIndent);
            clause.append(separators[i]);
            start = end + 1 + separators[i].length();
            i++;
        } while(true);
        clause = (StringBuffer)clauses.get(clauses.size() - 1);
        clause.append(sql.substring(start));
        StringBuffer pp = new StringBuffer(sql.length());
        Iterator iter = clauses.iterator();
        do
        {
            if(!iter.hasNext())
                break;
            pp.append(wrapLine(((StringBuffer)iter.next()).toString()));
            if(iter.hasNext())
                pp.append(newline);
        } while(true);
        return pp.toString();
    }

    private String wrapLine(String line)
    {
        StringBuffer lines = new StringBuffer(line.length());
        for(int i = 0; i < line.length() && (line.charAt(i) == ' ' || line.charAt(i) == '\t'); i++)
            lines.append(line.charAt(i));

        StringTokenizer tok = new StringTokenizer(line);
        int length = 0;
        while(tok.hasMoreTokens()) 
        {
            String elem = tok.nextToken();
            length += elem.length();
            if(length >= lineLength)
            {
                lines.append(newline);
                lines.append(wrapIndent);
                lines.append(elem);
                lines.append(' ');
                length = wrapIndent.length() + elem.length() + 1;
            } else
            if(elem.length() >= lineLength)
            {
                lines.append(elem);
                if(tok.hasMoreTokens())
                    lines.append(newline);
                lines.append(wrapIndent);
                length = wrapIndent.length();
            } else
            {
                lines.append(elem);
                lines.append(' ');
                length++;
            }
        }
        return lines.toString();
    }

    public static void main(String args[])
    {
        SQLFormatter formatter = new SQLFormatter();
        for(int i = 0; i < args.length; i++)
            System.out.println(formatter.prettyPrint(args[i]));

    }

    private boolean multiLine;
    private boolean doubleSpace;
    private String newline;
    private int lineLength;
    private String wrapIndent;
    private String clauseIndent;
    private static final String selectSeparators[] = {
        ",", "FROM ", "WHERE ", "ORDER BY ", "GROUP BY ", "HAVING "
    };
    private static final String insertSeparators[] = {
        "VALUES "
    };
    private static final String updateSeparators[] = {
        "SET ", "WHERE "
    };
    private static final String deleteSeparators[] = {
        "WHERE "
    };
    private static final String createTableSeparators[] = {
        "( "
    };
    private static final String createIndexSeparators[] = {
        "ON ", "( "
    };

}
