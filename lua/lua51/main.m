//
//  main.m
//  lua51
//
//  Created by 彭维剑 on 2020/11/30.
//  Copyright © 2020 pengweijian. All rights reserved.
//

#include "lua.hpp"
#include <stdio.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World! \n");
    lua_State *L = luaL_newstate(); // lua_open();
    luaL_openlibs(L);
    char *f = "/Users/pengweijian/MyDemos/lua/lua51/test/person.lua";
    //2.加载lua文件
    int bRet = luaL_loadfile(L, f);
    if(bRet)
    {
        printf("load file error\n");
        return 0;
    }
    
    //3.运行lua文件
    bRet = lua_pcall(L,0,0,0);
    if(bRet)
    {
        
        printf("pcall error");
        return 0;
    }

    lua_tostring(L, -1);
    return 0;
}
