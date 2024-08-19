package we.split

import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.TextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.text.input.KeyboardType
import java.text.NumberFormat
import java.util.Locale

@Composable
fun CurrencyTextField(
    value: Double,
    onValueChange: (Double) -> Unit,
    label: String = "Amount"
) {
    val currencyFormatter = remember { NumberFormat.getCurrencyInstance(Locale.getDefault()) }
    var textFieldValue by remember { mutableStateOf(currencyFormatter.format(value)) }

    TextField(
        value = textFieldValue,
        onValueChange = { newValue ->
            textFieldValue = newValue
            val parsed = newValue.replace(Regex("[^\\d.]"), "").toDoubleOrNull()
            if (parsed != null) {
                onValueChange(parsed)
                textFieldValue = currencyFormatter.format(parsed)
            }
        },
        label = { Text(label) },
        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
        singleLine = true
    )
}
