Shader "Custom/MultiLight"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Gloss("Gloss", range(0,1)) = 1
        _Color("Colour", color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Geometry"}

        Pass
        {
            Tags{"Lightmode" = "ForwardBase"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "IncLighting.cginc"
            
            ENDCG
        }
        
        //Additional Pass
        Pass
        {
            Blend One One
            
            Tags{"Lightmode" = "ForwardAdd"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd

            #include "IncLighting.cginc"
            
            ENDCG
        }
    }
}
