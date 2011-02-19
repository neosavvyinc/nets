package com.neosavvy.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: adamparrish
 * Date: Nov 29, 2009
 * Time: 5:50:44 PM
 */
public class StringUtil {
    private static final MessageDigest MESSAGE_DIGEST;
  public static final String[] EMPTY_ARRAY = new String[0];

  static {
      MessageDigest md;
      try {
          md = MessageDigest.getInstance("MD5");
      } catch(NoSuchAlgorithmException err) {
        throw new IllegalStateException();
      }
      MESSAGE_DIGEST = md;
  }
  private static final String HEX_CHARS = "0123456789ABCDEF";

  public static String getMD5(String source) {
      byte[] bytes;
      try {
        bytes = source.getBytes("UTF-8");
      } catch(java.io.UnsupportedEncodingException ue) {
        throw new IllegalStateException(ue);
      }
      byte[] result;
      synchronized(MESSAGE_DIGEST) {
          MESSAGE_DIGEST.update(bytes);
          result = MESSAGE_DIGEST.digest();
      }
      char[] resChars = new char[32];
      int len = result.length;
      for(int i = 0; i < len; i++) {
          byte b = result[i];
          int lo4 = b & 0x0F;
          int hi4 = (b & 0xF0) >> 4;
          resChars[i*2] = HEX_CHARS.charAt(hi4);
          resChars[i*2 + 1] = HEX_CHARS.charAt(lo4);
      }
      return new String(resChars);
  }

  public static String getHash32(String source) throws UnsupportedEncodingException {
      String md5 = getMD5(source);
      return md5.substring(0, 8);
  }

  public static String getHash64(String source) throws UnsupportedEncodingException {
      String md5 = getMD5(source);
      return md5.substring(0, 16);
  }
  

}
