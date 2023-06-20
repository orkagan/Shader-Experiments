Shader "Unlit/TransparantShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { 
            "RenderType"="Transparent"
            "Queue"="Transparent"
            }
        LOD 100

        Pass
        {
            Blend One One //additive
            //Blend DstColor One //Multiplative
            ZWrite Off
            //Cull Off
            Ztest LEqual
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                //v.vertex.y = (v.vertex.y)+sin(_Time.y *5+v.vertex.z *4) * 0.2;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                /*float xOffset = cos(i.uv.x * UNITY_TWO_PI * 8) * 0.01;
                float t = cos((i.uv.y+xOffset-_Time.y+0.1)*UNITY_TWO_PI *5)*0.5+0.5;

                t *= i.uv.y;
                
                return float4(t.xxx,1);*/
                return float4(0.5,0.5,0.5,0.5);
            }
            ENDCG
        }
    }
}
